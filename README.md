# Insider API

Rails API that requests insider transactions from SEC servers, scrapes FTP servers for corresponding XML files, parses files into database objects using [Nokogiri](https://www.nokogiri.org), and serves up JSON-formatted information to [Insider Client] (https://github.com/kimstephenson/insiderClient2) (repo). You can find live version [here] (https://yourinsider.herokuapp.com). 

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

```
heroku open
```

## Built With

* [Ruby on Rails](http://api.rubyonrails.org/) - Backend API framework used
* [React](https://facebook.github.io/react) - Front end UI framework used
* [Highcharts](https://www.highcharts.com) - Data visualization library
* [Redux](https://www.reduxjs.org) - Predictable state container used in front end application
* [PostgreSQL](https://www.postgresql.org/docs/) - Database used
* [HTTParty](https://github.com/jnunemaker/httparty) - Library used for making HTTP requests

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors

* **Israel Matos** - *Initial work* - [Github](https://github.com/everysum1)
* **Kim Stephenson** - [Github](https://github.com/kimstephenson)
* **Sam Parker** - [Github](https://github.com/samuelparker)
* **Youna Yang** - [Github](https://github.com/y0una)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

Thank you for all your help!!
* Jeff Tchang
* Dave Cheng
* Sally Park
