#' I have a data frame that indicates different skills that individuals possess
#' (1) or do not possess (0). I am trying to sort the data frame by the total
#' number of skills mastered, and then by each individual skill. So if two
#' individuals both possess three skills, the individual who possesses skill
#' 1 and skill 3 should be sorted ahead of an individual possessing skill 2 and
#' skill 3 (i.e., sort by total skill in ascending order, then by each component
#' skill in descending order).

library(tidyverse)

ex_data <- tibble(id      = c(1, 2, 3, 4, 5),
                  skill_1 = c(0, 0, 1, 1, 1),
                  skill_2 = c(1, 1, 0, 0, 0),
                  skill_3 = c(0, 1, 0, 1, 1))
ex_data

#' I can sort this example data manually, but I would prefer a solution that
#' doesn't require the hard coding of the variable names, as the number of
#' skills can change, and will not always be three.

ex_data %>%
  mutate(total = skill_1 + skill_2 + skill_3) %>%
  arrange(total, desc(skill_1, skill_2, skill_3))

#' I have tried to use tidyselect helpers, but it appears that the
#' `everything()` function does not work within `arrange()`. Is there anyway
#' to arrange the data frame without hard coding?

ex_data %>%
  rowwise() %>%
  mutate(total = sum(c_across(starts_with("skill")))) %>%
  ungroup() %>%
  arrange(total, desc(starts_with("skill")))
