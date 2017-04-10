library(readr)
h1b <- read_csv("~/workspace/r_working_directory/h1b_kaggle.csv")
View(h1b)
#dim(h1b)
#str(h1b)

library(dplyr)

names(h1b) <- c("row_no", "case_status", "employer_name", "soc_name", "job_title", "full_time_position", "wages","year", "worksite", "longitude", "latitude")

#remove both row_no and soc_name column
h1b <- h1b %>% select(-row_no, -soc_name)

library(tidyr)
h1b1 <- h1b %>% separate(col = worksite, into = c("city", "state"), sep = ", ")
View(h1b1)

statewise <- h1b1 %>% filter(!is.na(h1b1$case_status), full_time_position == "Y") %>% group_by(state) %>% summarise(
  certified = sum(ifelse(case_status == "CERTIFIED", 1, 0)),
  withdraw = sum(ifelse(case_status == "WITHDRAWN", 1, 0)),
  cert_withdraw = sum(ifelse(case_status == "CERTIFIED-WITHDRAWN", 1, 0)),
  reject = sum(ifelse(case_status == "REJECTED", 1, 0)),
  denied = sum(ifelse(case_status == "DENIED", 1, 0)),
  invalidated = sum(ifelse(case_status == "INVALIDATED", 1, 0)),
  pending = sum(ifelse(case_status == "PENDING QUALITY AND COMPLIANCE REVIEW - UNASSIGNED", 1, 0)),
  total = (certified+withdraw+cert_withdraw+reject+denied+invalidated+pending),
  avg_salary = mean(wages)
) %>% mutate(rank = rank(total)) %>% arrange(desc(rank))

View(statewise)

companywise <- h1b1 %>% filter(!is.na(h1b1$case_status), full_time_position == "Y") %>% group_by(employer_name) %>% summarise(
  certified = sum(ifelse(case_status == "CERTIFIED", 1, 0)),
  withdraw = sum(ifelse(case_status == "WITHDRAWN", 1, 0)),
  cert_withdraw = sum(ifelse(case_status == "CERTIFIED-WITHDRAWN", 1, 0)),
  reject = sum(ifelse(case_status == "REJECTED", 1, 0)),
  denied = sum(ifelse(case_status == "DENIED", 1, 0)),
  invalidated = sum(ifelse(case_status == "INVALIDATED", 1, 0)),
  pending = sum(ifelse(case_status == "PENDING QUALITY AND COMPLIANCE REVIEW - UNASSIGNED", 1, 0)),
  total = (certified+withdraw+cert_withdraw+reject+denied+invalidated+pending),
  avg_salary = mean(wages)
) %>% mutate(rank = rank(total)) %>% arrange(desc(rank), employer_name)

View(companywise)

yearwise <- h1b1 %>% filter(!is.na(h1b1$case_status), full_time_position == "Y") %>% group_by(year) %>% summarise(
  certified = sum(ifelse(case_status == "CERTIFIED", 1, 0)),
  withdraw = sum(ifelse(case_status == "WITHDRAWN", 1, 0)),
  cert_withdraw = sum(ifelse(case_status == "CERTIFIED-WITHDRAWN", 1, 0)),
  reject = sum(ifelse(case_status == "REJECTED", 1, 0)),
  denied = sum(ifelse(case_status == "DENIED", 1, 0)),
  invalidated = sum(ifelse(case_status == "INVALIDATED", 1, 0)),
  pending = sum(ifelse(case_status == "PENDING QUALITY AND COMPLIANCE REVIEW - UNASSIGNED", 1, 0)),
  total = (certified+withdraw+cert_withdraw+reject+denied+invalidated+pending),
  avg_salary = mean(!is.na(wages))
) %>% mutate(rank = rank(total)) %>% arrange(desc(rank))

View(yearwise)

jobtitlewise <- h1b1 %>% filter(!is.na(h1b1$case_status), full_time_position == "Y") %>% group_by(employer_name, job_title) %>% summarise(
  certified = sum(ifelse(case_status == "CERTIFIED", 1, 0)),
  withdraw = sum(ifelse(case_status == "WITHDRAWN", 1, 0)),
  cert_withdraw = sum(ifelse(case_status == "CERTIFIED-WITHDRAWN", 1, 0)),
  reject = sum(ifelse(case_status == "REJECTED", 1, 0)),
  denied = sum(ifelse(case_status == "DENIED", 1, 0)),
  invalidated = sum(ifelse(case_status == "INVALIDATED", 1, 0)),
  pending = sum(ifelse(case_status == "PENDING QUALITY AND COMPLIANCE REVIEW - UNASSIGNED", 1, 0)),
  total = (certified+withdraw+cert_withdraw+reject+denied+invalidated+pending),
  avg_salary = mean(!is.na(wages))
) %>% mutate(rank = rank(total)) %>% arrange(desc(rank))

View(jobtitlewise)

statecompanywise <- h1b1 %>% filter(!is.na(h1b1$case_status), full_time_position == "Y") %>% group_by(state, employer_name) %>% summarise(
  certified = sum(ifelse(case_status == "CERTIFIED", 1, 0)),
  withdraw = sum(ifelse(case_status == "WITHDRAWN", 1, 0)),
  cert_withdraw = sum(ifelse(case_status == "CERTIFIED-WITHDRAWN", 1, 0)),
  reject = sum(ifelse(case_status == "REJECTED", 1, 0)),
  denied = sum(ifelse(case_status == "DENIED", 1, 0)),
  invalidated = sum(ifelse(case_status == "INVALIDATED", 1, 0)),
  pending = sum(ifelse(case_status == "PENDING QUALITY AND COMPLIANCE REVIEW - UNASSIGNED", 1, 0)),
  total = (certified+withdraw+cert_withdraw+reject+denied+invalidated+pending),
  avg_salary = mean(!is.na(wages))
) %>% mutate(rank = rank(total)) %>% arrange(desc(rank))

View(statecompanywise)

statecitycompanywise <- h1b1 %>% filter(!is.na(h1b1$case_status), full_time_position == "Y") %>% group_by(state, city, employer_name) %>% summarise(
  certified = sum(ifelse(case_status == "CERTIFIED", 1, 0)),
  withdraw = sum(ifelse(case_status == "WITHDRAWN", 1, 0)),
  cert_withdraw = sum(ifelse(case_status == "CERTIFIED-WITHDRAWN", 1, 0)),
  reject = sum(ifelse(case_status == "REJECTED", 1, 0)),
  denied = sum(ifelse(case_status == "DENIED", 1, 0)),
  invalidated = sum(ifelse(case_status == "INVALIDATED", 1, 0)),
  pending = sum(ifelse(case_status == "PENDING QUALITY AND COMPLIANCE REVIEW - UNASSIGNED", 1, 0)),
  total = (certified+withdraw+cert_withdraw+reject+denied+invalidated+pending),
  avg_salary = mean(!is.na(wages))
  ) %>% mutate(rank = rank(total)) %>% arrange(desc(rank))

View(statecitycompanywise)
