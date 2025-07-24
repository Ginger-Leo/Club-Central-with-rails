# Club Central - Sports Team Management Web Application

## Introduction
Club Central is my sports team management application built with Ruby on Rails. It provides tools for managing team members, events, finances, and administrative tasks all in a web based app.

## Features
- **User Management**: Registration, authentication, and role-based access control
- **Event Management**: Create, update, and track team events
- **Financial Management**: Track payments, balances, and club finances
- **Administrative Hub**: Centralized dashboard for team oversight
- **Responsive Design**: Works across desktop and mobile devices

## System Requirements
- Ruby 3.0+ 
- Rails 7.0+
- PostgreSQL database
- Ubuntu/Linux environment
- Modern web browser (google chrome)

## Installation Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ginger-Leo/Club-Central-with-rails-.git
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Database setup**
   - Ensure PostgreSQL is installed and running
   - Configure your database credentials in `config/database.yml`
   - Run database setup:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the application**
   ```bash
   rails server
   ```
   Open your web browser and navigate to `http://localhost:3000`



## Limitations and Known Issues
- Requires PostgreSQL database setup
- System tests require Chrome/Chromium browser and chromedriver
- Designed primarily for Ubuntu/Linux environments
- Currently supports single-club management
- Admin privileges required for user promotion/demotion

## Support
For questions, issues, or suggestions, please contact:
**Leo Storey** - [leo.storey@mainiotech.fi](mailto:leo.storey@mainiotech.fi)

## License
Copyright 2025 Mainio Tech Oy

This application is licensed under the Creative Commons Attribution-NonCommercial 4.0 International Public License. For more information about the license, visit: https://creativecommons.org/licenses/by-nc/4.0/legalcode