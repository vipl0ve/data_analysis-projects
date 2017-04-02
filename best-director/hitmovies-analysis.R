library(readr)
movies <- read_csv("~/workspace/r_working_directory/movies.csv")
View(movies)

library(dplyr)
library(tidyr)
library(dplyr)
library(stringr)

class(movies)
str(movies)
summary(movies)

#movie will be a hit if imdb score is more than 7
movies <- movies %>% mutate(hit = ifelse(imdb_score > 7, 1, 0))

#subset the hit movies
hitmovies <- movies[movies$hit == 1, ]

#View the hit movies
View(hitmovies)

str(hitmovies)

#sort the movies based on imdb score and gross and remove all movies with number of votes less than 1000
hitmovies <- hitmovies %>% arrange(desc(imdb_score), desc(gross)) %>% filter(num_voted_users > 1000)

#Remove all duplicate rows
hitmovies <- hitmovies[!duplicated(hitmovies$movie_title),]

#add a profit variable
hitmovies <- hitmovies %>% mutate(profit = gross-budget)

#replace all NA in language variable with None
hitmovies$language[which(is.na(hitmovies$language))] <- "None"

#remove all the movies from the list which do not have director's name
hitmovies <- hitmovies[which(!is.na(hitmovies$director_name)),]

#convert all grouping variable into factors
hitmovies$language <- as.factor(hitmovies$language)
hitmovies$country <- as.factor(hitmovies$country)
hitmovies$content_rating <- as.factor(hitmovies$content_rating)
hitmovies$actor_1_name <- as.factor(hitmovies$actor_1_name)
hitmovies$director_name <- as.factor(hitmovies$director_name)


#covert hit variable into logical variable
hitmovies$hit <- as.logical(hitmovies$hit)

str(hitmovies)

#Most successful director (no of hit movies, avg imdb score, avg budget, avg gross, profit sort)
bestdirector <- hitmovies %>% group_by(director_name) %>% summarise(movies = sum(hit), imdb = sum(imdb_score), imdb_avg = mean(imdb_score), budget = mean(!is.na(budget)), gross = mean(!is.na(gross)), profit = mean(!is.na(profit))) %>% mutate(rank = rank(imdb, na.last = NA)) %>% arrange(desc(rank))
View(bestdirector)

#List of all the steven Speilberg movies
steven_movies <- hitmovies[hitmovies$director_name == 'Steven Spielberg',] %>% arrange(desc(imdb_score))
View(steven_movies)

#export the hitmovies dataframe into bestdirector.csv file
write.csv(bestdirector, "bestdirector.csv")

#Most successful year (no of hit movies, avg imdb score, avg budget, avg gross, profit)
View(hitmovies %>% group_by(title_year) %>% summarise(movies = sum(hit), imdb = mean(imdb_score), budget = mean(!is.na(budget)), gross = mean(!is.na(gross)), profit = mean(!is.na(profit))) %>% mutate(rank = rank(movies, na.last = NA)) %>% arrange(desc(rank)))
