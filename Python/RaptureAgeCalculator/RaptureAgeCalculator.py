from datetime import datetime

### Calculate Rapture Age based on birthdate
### Rapture Age is defined as the number of times the rapture was predicted
### since the person's birth year up to the current year.


def rapture_age_calculator(birthdate_str, current_year=2025 ):
    # List of major rapture prediction years
    rapture_years = [
        1843, 1844, 1874, 1878, 1881, 1910, 1914, 1918, 1925, 1975, 1975,
        1981, 1981, 1982, 1988, 1988, 1989, 1992, 1993, 1994, 1994, 1995,
        2000, 2000, 2001, 2007, 2011, 2011, 2012, 2014, 2015, 2017, 2020, 2021, 2025
    ]
    # Convert birthdate string to year
    birth_year = datetime.strptime(birthdate_str, '%Y-%m-%d').year
    current_year = 2025
    # Count number of times rapture was predicted since birth
    missed = [year for year in rapture_years if birth_year <= year < current_year]
    rapture_age = len(missed)
    return rapture_age, missed

# Example usage:
rapture_age, missed_years = rapture_age_calculator('1983-07-16')
print(f"You are '{rapture_age}' in Rapture Age. You missed the following raptures: {missed_years}")
