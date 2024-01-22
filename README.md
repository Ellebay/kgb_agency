# MarionBlancher - Créer une application web

## Deploy to Heroku
When you click the button, it will automatically clone the repo to your chosen Git provider, as well as deploy it automatically to Netlify!

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/Ellebay/GDWFSCAWEXAIII1A_MarionBlancher)

### Database using Stackhero for MySQL in Heroku
When deploying on Heroku, it will use Stackhero for MySQL add-ons, with the smallest plan, but keep in mind that you can be charge for this !

See more information here: https://devcenter.heroku.com/articles/ah-mysql-stackhero#provisioning-the-add-on

### Create an .env file
Create an .env file with your database information, you can find those information in the ressources of the add-ons Stackehero for MySQL in your Heroku dashboard.

```
STACKHERO_MYSQL_HOST= host name
STACKHERO_MYSQL_PASSWORD= password
STACKHERO_MYSQL_USER= username
STACKHERO_MYSQL_NAME= bdd name
```