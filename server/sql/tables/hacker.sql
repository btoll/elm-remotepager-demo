USE elmremotepagerdemo;

DROP TABLE IF EXISTS `hacker` ;

CREATE TABLE IF NOT EXISTS `hacker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ID` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ;

LOCK TABLES `hacker` WRITE ;
INSERT `hacker` (`id`, `name`) VALUES
(NULL, 'Mark Abene'),
(NULL, 'Ryan Ackroyd'),
(NULL, 'Mustafa Al-Bassam'),
(NULL, 'Mitch Altman'),
(NULL, 'Jacob Appelbaum'),
(NULL, 'Julian Assange'),
(NULL, 'Trishneet Arora'),
(NULL, 'Weev'),
(NULL, 'Loyd Blankenship'),
(NULL, 'Erik Bloodaxe'),
(NULL, 'Max Butler'),
(NULL, 'Phone Losers of America'),
(NULL, 'Jean-Bernard Condat'),
(NULL, 'Kim Dotcom'),
(NULL, 'John Draper'),
(NULL, 'Sir Dystic'),
(NULL, 'Alexandra Elbakyan'),
(NULL, 'Nahshon Even-Chaim'),
(NULL, 'Ankit Fadia'),
(NULL, 'Bruce Fancher'),
(NULL, 'Joe Grand'),
(NULL, 'Richard Greenblatt'),
(NULL, 'Virgil Griffith'),
(NULL, 'Rop Gonggrijp'),
(NULL, 'Guccifer'),
(NULL, 'Guccifer 2.0'),
(NULL, 'Jeremy Hammond'),
(NULL, 'Susan Headley'),
(NULL, 'Markus Hess'),
(NULL, 'Billy Hoffman'),
(NULL, 'George Hotz'),
(NULL, 'Sam Jain'),
(NULL, 'The Jester'),
(NULL, 'Jonathan James'),
(NULL, 'Joybubbles'),
(NULL, 'Karl Koch'),
(NULL, 'Alan Kotok'),
(NULL, 'Patrick K. Kroupa'),
(NULL, 'Adrian Lamo'),
(NULL, 'Chris Lamprecht'),
(NULL, 'Gordon Lyon'),
(NULL, 'MafiaBoy'),
(NULL, 'Morgan Marquis-Boire'),
(NULL, 'Gary Mckinnon'),
(NULL, 'Jude Milhon'),
(NULL, 'Kevin Mitnick'),
(NULL, 'Mixter'),
(NULL, 'Hector Monsegur'),
(NULL, 'HD Moore'),
(NULL, 'Robert Tappan Morris'),
(NULL, 'Dennis Moran'),
(NULL, 'Andy Müller-Maguhn'),
(NULL, 'Craig Neidorf'),
(NULL, 'Rafael Núñez'),
(NULL, 'Justin Tanner Petersen'),
(NULL, 'Kevin Poulsen'),
(NULL, 'Grandmaster Ratte'),
(NULL, 'Christien Rioux'),
(NULL, 'Leonard Rose'),
(NULL, 'Oxblood Ruffin'),
(NULL, 'Joanna Rutkowska'),
(NULL, 'Peter Samson'),
(NULL, 'Roman Seleznev'),
(NULL, 'Alisa Shevchenko'),
(NULL, 'Rich Skrenta'),
(NULL, 'Dmitry Sklyarov'),
(NULL, 'Edward Snowden'),
(NULL, 'Richard Stallman'),
(NULL, 'StankDawg'),
(NULL, 'Matt Suiche'),
(NULL, 'Gottfrid Svartholm'),
(NULL, 'Kristina Svechinskaya'),
(NULL, 'Aaron Swartz'),
(NULL, 'Ehud Tenenbaum'),
(NULL, 'John Threat'),
(NULL, 'Topiary'),
(NULL, 'Tron'),
(NULL, 'Justine Tunney'),
(NULL, 'Kimberley Vanvaeck'),
(NULL, 'Steve Wozniak'),
(NULL, 'Chris Wysopal'),
(NULL, 'YTCracker'),
(NULL, 'Peiter Zatko');
UNLOCK TABLES ;

