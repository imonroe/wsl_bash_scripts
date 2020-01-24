# Ian's Helpers -- WSL friendly bash scripts for various things.

This is a small collection of bash scripts that I find useful for various tasks.  Tested with Ubuntu 18.04 in Windows Subsystem for Linux.  May be useful elsewhere, your milage may vary.  No warranty expressed or implied, use at your own risk.


Contents include:

- `setup_stack.sh`
  - This is a script to help automate the setup of a Drupal-ish local LAMP stack in WSL
- `/apache/make_new_site.sh`
  - If you've set up a localdev using the setup_stack script, this automates the process of quickly creating new sites and activating them in apache.  Optionally uses the create_database script to setup a DB for your site as well.
- `/apache/create_database.sh`
  - Grabs some input and sets you up a new database and a user with permissions on the database.  Use for prepping a new site.


## Installation

Clone to a convenient location.  You may need to set executable permissions.  This ought to do the trick:
`chmod -R +x *.sh`

## Comments, requests, suggestions

Got an idea that belongs in this repo?  Get in touch with me at ian (at) ianmonroe.com and let me know.  Who knows?  The next good time saver might come from YOU!

