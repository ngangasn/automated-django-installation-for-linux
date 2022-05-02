echo "Enter the directory that will be created on your Desktop directory. This will be used to store your project's files such as manage.py:  "
read project_desktop_directory
echo "Enter the name that you want to call your project: "
read project_name

# sudo apt update
sudo apt install python3 python3-pip virtualenv

if [ -d ~/Desktop/$project_desktop_directory/ ] 
then
    cd $HOME/Desktop/$project_desktop_directory
    echo "Cd'd into the desktop directory ..."

else
	mkdir ~/Desktop/$project_desktop_directory
	 cd $HOME/Desktop/$project_desktop_directory
	echo "Created a new directory into the desktop folder called $project_name "
fi

if [ -d ~/.virtualenvs/$project_name ]
then 
	. "$HOME/.virtualenvs/$project_name/bin/activate"
	echo "Activated virtual env"
else
	python3 -m venv ~/.virtualenvs/$project_name
	. "$HOME/.virtualenvs/$project_name/bin/activate"
	echo "Created a new env and activated it"
fi
pip install django

echo "Creating a new Django project named $project_name "
if [ -f ~/Desktop/$project_desktop_directory/manage.py ]
then 
	python manage.py runserver & sleep 10 & xdg-open http://127.0.0.1:8000/
else
	django-admin startproject $project_name .
	python manage.py runserver & sleep 10 & xdg-open http://127.0.0.1:8000/
fi

exec bash
