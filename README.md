Komana
==============

The jobless Donkeys
--------------
*Michael Landreh
*Sebastian Schmitt
*Sergej Fedorchenko
*Kevin Thielen

ABOUT
--------------
Komana ist ein Projektmanagement-tool. Der Benutzer kann in seinem Projekt listen anlegen und verschieben,
sowie einzelne Aufgaben per Drag and Drop den einzelnn Listen zuweisen.
Benutzer können mittels Nachrichten mit einander Kommunizieren.

SETUP
--------------
- 'git clone https://github.com/KevinThielen/Komana.git' 
- Falls noch nicht installiert: 'apt-get install libpq-dev' und 'apt-get install libsqlite3-dev'
- 'bundle install' im root verzichnis des Projekts aufrufen
- 'rake db:migrate'
- 'rake db:migrate RAILS_ENV=test' für rspec tests
- 'rake db:seed' für seed daten
- 'rspec' um alle rspec tests durchlaufen zu lassen
- 'rails server'
- Seed User Login: 'natural@selection.uk'
			 Passwort: 'Evolution'
- Für Passwortreset: $ export GMAIL_SMTP_USER=username@gmail.com
$ export GMAIL_SMTP_PASSWORD=yourpassword

Heroku Link
--------------
http://lit-savannah-9375.herokuapp.com/

Active Admin
--------------
   http://localhost:3000/admin/
bzw. http://lit-savannah-9375.herokuapp.com/admin/

   Admin Login: 'admin@example.com'
		 Passwort: 'password'
		 
User Stories
--------------
als PDF im Wurzelverzeichnis des Projekts		

zusätzliche GEMS
--------------
* activeadmin (1.0.0.pre d7a2624)
* rolify (3.2.0)
* cancan (1.6.10)
* pg (0.17.1)
* rails_12factor (0.0.2)
* capybara (2.2.1)
* rspec-rails (3.0.0.beta2)
* sqlite3 (1.3.8)
* bootstrap-datepicker-rails (1.3.0.1)
* bootstrap-sass (3.0.3.0)
* rails-i18n (4.0.1)
* mailboxer (0.11.0)
* execjs (2.0.2)
* therubyracer (0.12.0)
* devise (3.2.2)
* devise-i18n-views (0.2.8)


