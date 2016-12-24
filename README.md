# Smarter Bear API

Ever wanted to see at a glance what the top insiders from the hottest companies are doing with their shares of company stock?

This Rails API does all the back end data processing to make that happen.  It requests insider transactions from SEC servers, scrapes FTP servers for corresponding XML files, parses files into database objects using [Nokogiri](https://www.nokogiri.org), and serves up JSON-formatted information to deployed front end [Insider Client](https://yourinsider.herokuapp.com). 

You can also check out the Github repo [here](https://github.com/everysum1/insiderClient). 

![homepage] (https://github.com/everysum1/insiderAPI/blob/development/app/assets/images/SmarterBearHomepage.png)

![company-page] (https://github.com/everysum1/insiderAPI/blob/development/app/assets/images/SmarterBearCompany.png)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

```
ruby 2.3.1
bundler 1.12.5
rails 5.0.0
```

### Installing
From the command terminal, clone the repository to your local directory...
```
$ git clone https://www.gihub.com/everysum1/insiderAPI.git
$ cd insiderAPI
```

Then run bundle command to install all dependencies and run the server.  

```
$ bundle install
$ rails server
```


## Running ALL the tests

```
bundle exec rspec spec
```

## Deployment

You must have Heroku CLI installed and be logged in to Heroku in order to deploy live via Heroku servers
(Please see the [documentation](https://devcenter.heroku.com) to get set up with Heroku)

Then, after installation and login, via the command line...
```
$ heroku create
$ git push heroku master
$ heroku open
```

## Built With

* [Ruby on Rails](http://api.rubyonrails.org/) - Backend API framework used
* [React](https://facebook.github.io/react) - Front end UI framework used
* [Highcharts](https://www.highcharts.com) - Data visualization library
* [Redux](https://www.reduxjs.org) - Predictable state container used in front end application
* [Nokogiri](https://nokogiri.org) - XML parser used
* [PostgreSQL](https://www.postgresql.org/docs/) - Database used
* [HTTParty](https://github.com/jnunemaker/httparty) - Library used for making HTTP requests

## Authors

* **Israel Matos** - [Github](https://github.com/everysum1)
* **Kim Stephenson** - [Github](https://github.com/kimstephenson)
* **Sam Parker** - [Github](https://github.com/samuelparker)
* **Youna Yang** - [Github](https://github.com/y0una)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

Thank you for all your help!!
* Jeff Tchang
* Dave Cheng
* Sally Park
