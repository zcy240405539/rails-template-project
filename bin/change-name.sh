#!/bin/bash
echo -n "Enter new name of web application: "
read APP_NAME
APP_TITLE=$(echo $APP_NAME | awk 'BEGIN{split("a the to at in on with and but or",w); for(i in w)nocap[w[i]]}function cap(word){return toupper(substr(word,1,1)) tolower(substr(word,2))}{for(i=1;i<=NF;++i){printf "%s%s",(i==1||i==NF||!(tolower($i) in nocap)?cap($i):tolower($i)),(i==NF?"\n":" ")}}'
)
APP_TITLE="$(echo -e "${APP_TITLE}" | tr -d '[:space:]')"
APP_STRING=$(echo $APP_NAME | tr -s ' ' | tr ' ' '-')
sed "s/RailsTemplateProject/$APP_TITLE/g" config/application.rb
sed "s/RailsTemplateProject/$APP_TITLE/g" app/views/layouts/application.html.erb
sed "s/rails-template-project/$APP_STRING/g" package.json
sed "s/rails-template-project/$APP_STRING/g" config/database.yml
sed "s/rails-template-project/$APP_STRING/g" config/cable.yml
sed "s/rails-template-project/$APP_STRING/g" config/environments/production.rb
