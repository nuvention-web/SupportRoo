# SupportRoo

![SupportRoo Logo](https://github.com/nuvention-web/SupportRoo/blob/master/app/assets/images/logo.png?raw=true)

We believe that everyone should have the help they need when they need it most. SupportRoo allows you to organize help for yourself or friends in times of stress, and allows you to be sure everything you need gets done.

SupportRoo helps anyone who has too many things to keep track of to identify what they need to get done, organize those needs, and share them with their network so people who want to help can.  This could include anyone ranging from a serious long term illness, to a less serious injury or a new mother wanting to keep track of things at home.

## Team Members
* Avy Faingezicht: Software Engineering/Business
* Alex Kowalczuk: Software Engineering/Design
* Claire McCloskey: Design/Content
* Sami Nerenberg: Strategy/Design/Content


## SupportRoo

We have staging and production hosts on heroku, with the production box also deployed on supportroo.com

* Production: http://supportroo.herokuapp.com
* Staging: http://supportroo-staging.herokuapp.com

## Technology

### System Dependencies
- Ruby 2.1.2
- PostgreSQL 9.3.5

### Installation

First, clone the repository:

`$ git clone git@github.com:nuvention-web/SupportRoo.git`

SupportRoo is a built using Rails.  To get started, simply run:

`bundle install`

Then set up your database, we use PostgreSQL by default, so assuming you have it install, run:

```
rake db:create
rake db:migrate
rake db:seed
```

This will install all dependencies including:
* Ruby 2.1.2
* Rails 4.2
* jQuery

For more information, check the Gemfile.

### Running Locally
To run the app, simply run

`rails server`

### Running Tests

We have a full suite of unit tests.  To run them alongside the application as you develop, you can run

`guard`

This will launch a watcher that reruns the appropriate tests every time a file is changed.

### Deploying

Deployment is automated through [Circle CI](https://circleci.com/).  Every push will go through Circle to make sure all tests passed the and build is OK to launch.


## User Development

### Customer segment and use case

Our customer segment is fairly broad and generally encompasses anyone who is going through a new situation of stress.  This includes (but is not limited to)

- Injuries
- New Mothers
- Serious Illness
- Spouse Deployment
- Elderly Parents
- Death in the Family

### Value proposition and key features

SupportRoo allows users to organize their lives and engage their networks distribute the load.

Key features:
- Add tasks from various categories onto your calendar and task list
- Invite friends to your board so they can view, sign up for, and complete those tasks
- Get email notifications when tasks are signed up for and completed
- Set reminders and confirmation texts to send to people who sign up
- Integration with SMS through Twilio that allows supporters to complete tasks by replying to test messages


## Other Documents

### Previous decks
* [Winter EOQ Pitch](https://docs.google.com/presentation/d/1rOY2qvQqqfZhx-H8c9zlTn8QVq8WFCHBik1NsJ7MHg8/ "Winter EOQ Pitch")
* [Spring Mid PPT](https://docs.google.com/presentation/d/1b6Bp0wFNnbxwCth7VPDeAap9an68MJ4WBRybRqeIJ0s/ "Spring Mid PPT")

#### Final Presentation Deck
* [Spring EOQ Pitch](https://docs.google.com/presentation/d/1nbBn0MJrdUO_ZAMVSNoDkO-em2A78Mj9eh83BnzySG0/ "Spring EOQ Pitch")

### Launchpad Central
#### Business Canvas
* [Week 10 Spring BMC](https://www.dropbox.com/s/9vww60lvcasxjbk/LaunchPad%20Central_Week23.pdf?dl=0 "Week 10 Spring BMC")

#### Interviews and user feedback
* [Inverview contact database](https://www.dropbox.com/s/hmynwyj9kn599hc/SupportRoo%20Interview%20Contacts.csv?dl=0)

### Videos
* [How to add tasks](https://www.youtube.com/watch?v=aqAREu68y0w "How to add tasks:")
* [User Testimonial] (https://www.youtube.com/watch?v=4S5FoiaeG3E&feature=youtu.be)
* [Winter EOQ Video] (https://www.youtube.com/watch?v=bI1r_Cwxnyw&feature=youtu.be) 
