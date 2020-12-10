| Verb | Route | View |
|------|-------|------|
| GET | /songs | index | #Get all the songs
| GET | /songs/:id | show | #Get 1 songs '/songs/6'
| GET | /songs/new| new | #Get the form to make a song
| POST | /songs | | #Create a song
| GET | /songs/:id/edit | edit | #Get a form to edit 1 song
| PUT/PATCH | /songs/:id | | #update 1 song
| DELETE | /songs/:id | | #delete 1 song

#pushing changes to git hub

git add .
git commit -m "message"
git push