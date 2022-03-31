USE albums_db;
DESCRIBE albums;
-- a. How many rows are in the albums table? 31
SELECT *
	FROM albums;
-- b. How many unique artist names are in the albums table? 23
SELECT DISTINCT artist
	FROM albums;
-- c. What is the primary key for the albums table? id
DESCRIBE albums;
-- d. What is the oldest release date for any album in the albums table? What is the most recent release date? oldest = 1967, newest = 2011
SELECT *
FROM albums
WHERE release_date >= 1990;
-- 4 
-- a. The name of all albums by Pink Floyd: The Wall, The Dark Side Of the Moon
SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released: 1967
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- c. The genre for the album Nevermind: Grunge, Alternative rock
SELECT genre FROM albums WHERE name = 'Nevermind';
-- d. Which albums were released in the 1990s: '5', 'Whitney Houston / Various artists', 'The Bodyguard', '1992', '28.4', 'R&B, Soul, Pop, Soundtrack'('20', 'The Beatles', '1', '2000', '22.6', 'Rock''13', 'Shania Twain', 'Come On Over', '1997', '29.6', 'Country, Pop''30', 'Santana', 'Supernatural', '1999', '20.5', 'Rock''28', 'Nirvana', 'Nevermind', '1991', '16.7', 'Grunge, Alternative rock''21', 'Michael Jackson', 'Dangerous', '1991', '16.3', 'Rock, Funk, Pop''27', 'Metallica', 'Metallica', '1991', '21.2', 'Thrash metal, Heavy metal''22', 'Madonna', 'The Immaculate Collection', '1990', '19.4', 'Pop, Dance''26', 'James Horner', 'Titanic: Music from the Motion Picture', '1997', '18.1', 'Soundtrack''14', 'Celine Dion', 'Falling into You', '1996', '20.2', 'Pop, Soft rock''19', 'Celine Dion', 'Let\'s Talk About Love', '1997', '19.3', 'Pop, Soft rock''12', 'Alanis Morissette', 'Jagged Little Pill', '1995', '24.4', 'Alternative rock')

SELECT *
	FROM albums
	WHERE release_date BETWEEN 1989 and 2000;
    
-- e. Which albums had less than 20 million certified sales: Abbey Road, Bad, Born in U.S.A., Brothers in Arms, Dangerous, Dirty Dancing, Grease: The Original Soundtrack, Let's Talk About Love, Nevermind,'15', 'Sgt. Pepper\'s Lonely Hearts Club Band', The Immaculate Collection, The Wall, Titanic
SELECT *
	FROM albums
    WHERE sales < 20;
    
-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock": # id, artist, name, release_date, sales, genre'15', 'The Beatles', 'Sgt. Pepper\'s Lonely Hearts Club Band', '1967', '13.1', 'Rock''20', 'The Beatles', '1', '2000', '22.6', 'Rock''23', 'The Beatles', 'Abbey Road', '1969', '14.4', 'Rock''24', 'Bruce Springsteen', 'Born in the U.S.A.', '1984', '19.6', 'Rock''30', 'Santana', 'Supernatural', '1999', '20.5', 'Rock'---------- progressive rock and rock are two different categories.

SELECT *
	FROM albums
    WHERE genre = 'rock';