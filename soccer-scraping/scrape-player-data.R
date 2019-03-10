team_url <- 'https://www.fifaindex.com/players/?team=5'
team_page <- read_html(team_url)

player_url <- team_page %>%  html_nodes(xpath="//td[@data-title='Name']/a/@href") %>% html_text()
player_newurl <- paste('https://www.fifaindex.com', player_url, sep = "")

#gk_url <- c('https://www.fifaindex.com/player/192119/thibaut-courtois/',
#            'https://www.fifaindex.com/player/172723/asmir-begovi%C4%87/', 
#            'https://www.fifaindex.com/player/163873/eduardo/', 
#            'https://www.fifaindex.com/player/225543/bradley-collins/')

for (url in player_newurl)
{
  web_page <- read_html(url)

  player_name <- web_page %>%  html_nodes(xpath="//h2[position()=1]") %>% html_text()
  player_country <- web_page %>%  html_nodes(xpath="//h2[position()=2]") %>% html_text()

  player_xpath <- sprintf("//h3[contains(text(), '%s')]/parent::div/following-sibling::div/p",player_name)
  player_text <- web_page %>%  html_nodes(xpath=player_xpath) %>% html_text()
  
  country_xpath <- sprintf("//a[@title='%s']/parent::h3/parent::div/following-sibling::div/p",player_country)
  country_text <- web_page %>%  html_nodes(xpath=country_xpath) %>% html_text()

  club_text <- web_page %>%  html_nodes(xpath="//a[@title='Chelsea']/parent::h3/parent::div/following-sibling::div/p") %>% html_text()

  ball_skill_text <- web_page %>%  html_nodes(xpath="//h3[text()='Ball Skills']/parent::div/following-sibling::div/p") %>% html_text()
  defence_text <- web_page %>%  html_nodes(xpath="//h3[text()='Defence']/parent::div/following-sibling::div/p") %>% html_text()
  passing_text <- web_page %>%  html_nodes(xpath="//h3[text()='Passing']/parent::div/following-sibling::div/p") %>% html_text()
  mental_text <- web_page %>%  html_nodes(xpath="//h3[text()='Mental']/parent::div/following-sibling::div/p") %>% html_text()
  passing_text <- web_page %>%  html_nodes(xpath="//h3[text()='Passing']/parent::div/following-sibling::div/p") %>% html_text()
  shooting_text <- web_page %>%  html_nodes(xpath="//h3[text()='Shooting']/parent::div/following-sibling::div/p") %>% html_text()
  physical_text <- web_page %>%  html_nodes(xpath="//h3[text()='Physical']/parent::div/following-sibling::div/p") %>% html_text()
  goalkeeper_text <- web_page %>%  html_nodes(xpath="//h3[text()='Goalkeeper']/parent::div/following-sibling::div/p") %>% html_text()

  # print("###############################")
  print(player_name)
  # print(country_text)
  # print("---PLAYER---")
  # print(player_text)
  # print("---COUNTRY---")
  # print(country_text)
  # print("---CLUB---")
  # print(club_text)
  # print("---BALL SKILLS---")
  # print(ball_skill_text)
  # print("---DEFENCE---")
  # print(defence_text)
  # print("---SHOOTING---")
  # print(passing_text)
  # print("---MENTAL---")
  # print(mental_text)
  # print("---SHOOTING---")
  # print(shooting_text)
  # print("---PHYSICAL---")
  # print(physical_text)
  # print("---GOALKEEPR---")
  # print(goalkeeper_text)
  # print("###############################")
  
}