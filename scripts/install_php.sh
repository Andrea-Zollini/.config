#!/bin/bash

# Function to check PHP installation
check_php_ini() {
    echo "Checking PHP configuration file location..."
    if command -v php > /dev/null; then
        php -r "echo php_ini_loaded_file() . \"\n\";"
        echo "Additional .ini files are loaded from:"
        php -r "echo php_ini_scanned_files() . \"\n\";"
    else
        echo "PHP is not installed or not in PATH."
    fi
}

uninstall_php() {
    echo "Uninstalling PHP from your system..."

    # Check for apt installed PHP
    if dpkg -l | grep -i php > /dev/null; then
        echo "Removing PHP packages..."
        sudo apt-get purge 'php*' -y
        sudo apt-get autoremove --purge -y
    fi

    # Remove PHP binaries in common locations
    echo "Removing PHP binaries and configuration files..."
    sudo rm -rf /usr/bin/php*
    sudo rm -rf /usr/sbin/php*
    sudo rm -rf /usr/local/bin/php*
    sudo rm -rf /etc/php/
    sudo rm -rf /usr/lib/php/
    sudo rm -rf /usr/share/php/
    sudo rm -rf /usr/local/php*

    # Check for Herd Lite installation
    if [ -d "$HOME/.config/herd-lite" ]; then
        echo "Detected Herd Lite installation. Removing..."
        if command -v herd > /dev/null; then
            herd stop
        fi
        rm -rf $HOME/.config/herd-lite
    fi

    # Remove PHP from alternatives system
    if command -v update-alternatives > /dev/null; then
        echo "Removing PHP from alternatives system..."
        sudo update-alternatives --remove-all php 2>/dev/null || true
    fi

    # Clear shell cache
    hash -r

    echo "PHP has been uninstalled from your system."
}

# Function to install PHP from source
install_php_from_source() {
    local VERSION=$1

    if [ -z "$VERSION" ]; then
        echo -n "Which PHP version do you want to install? "
        read VERSION

        if [ -z "$VERSION" ]; then
	    echo "No version selected."
	    echo -n "Do you want to uninstall PHP instead (yes/no):"
            read UNINSTALL

	    if [[ "$UNINSTALL" == "yes" ]]; then
		uninstall_php
		return 0
	    else
		echo "Operation cancelled."
		return 1
	    fi
	fi
    fi

    echo "=========================================="
    echo "Installing PHP $VERSION from source"
    echo "=========================================="

    # Install dependencies
    echo "Installing dependencies..."
    sudo apt update
    sudo apt install -y build-essential \
                        libxml2-dev \
                        libssl-dev \
                        libzip-dev \
                        libsqlite3-dev \
                        libcurl4-openssl-dev \
                        libpng-dev \
                        libjpeg-dev \
                        libonig-dev \
                        libreadline-dev \
                        libtidy-dev \
                        libxslt-dev \
                        autoconf \
                        pkg-config \
                        re2c

    # Create a temporary directory for the build
    local BUILD_DIR=$(mktemp -d)
    cd "$BUILD_DIR"

    # Download and extract PHP
    echo "Downloading PHP $VERSION..."
    wget "https://www.php.net/distributions/php-$VERSION.tar.gz"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to download PHP $VERSION. Please verify the version number."
        rm -rf "$BUILD_DIR"
        return 1
    fi

    echo "Extracting PHP $VERSION..."
    tar -xzf "php-$VERSION.tar.gz"
    cd "php-$VERSION"

    # Configure PHP
    echo "Configuring PHP $VERSION..."
    ./configure --prefix=/usr/local/php-$VERSION \
                --with-config-file-path=/usr/local/php-$VERSION/etc \
                --with-zlib \
                --with-openssl \
                --with-curl \
                --enable-ftp \
                --enable-mbstring \
                --enable-mysqlnd \
                --with-mysqli=mysqlnd \
                --with-pdo-mysql=mysqlnd \
                --enable-intl \
                --with-jpeg \
                --with-zip \
                --with-tidy \
                --with-xsl \
                --with-readline \
                --enable-soap \
                --enable-xml \
                --enable-exif \
                --enable-bcmath \
                --enable-calendar \
                --enable-fpm \
                --with-fpm-user=www-data \
                --with-fpm-group=www-data

    if [ $? -ne 0 ]; then
        echo "Error: Configuration failed. Check the output above for details."
        rm -rf "$BUILD_DIR"
        return 1
    fi

    # Build and install PHP
    echo "Building PHP $VERSION (this may take a while)..."
    make -j$(nproc)

    if [ $? -ne 0 ]; then
        echo "Error: Build failed. Check the output above for details."
        rm -rf "$BUILD_DIR"
        return 1
    fi

    echo "Installing PHP $VERSION..."
    sudo make install

    if [ $? -ne 0 ]; then
        echo "Error: Installation failed. Check the output above for details."
        rm -rf "$BUILD_DIR"
        return 1
    fi

    # Create symbolic links
    echo "Creating symbolic links..."
    sudo ln -sf /usr/local/php-$VERSION/bin/php /usr/local/bin/php
    sudo ln -sf /usr/local/php-$VERSION/bin/phpize /usr/local/bin/phpize
    sudo ln -sf /usr/local/php-$VERSION/bin/php-config /usr/local/bin/php-config

    # Create ini file
    echo "Creating php.ini..."
    sudo mkdir -p /usr/local/php-$VERSION/etc
    sudo cp php.ini-development /usr/local/php-$VERSION/etc/php.ini

    # Clean up
    cd
    rm -rf "$BUILD_DIR"

    # Verify installation
    echo "Verifying PHP installation..."
    php -v

    echo "=========================================="
    echo "PHP $VERSION has been successfully installed!"
    echo "PHP binary location: /usr/local/bin/php"
    echo "PHP configuration: /usr/local/php-$VERSION/etc/php.ini"
    echo "=========================================="

    return 0
}

# Execute the function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_php_from_source "$@"
fi
