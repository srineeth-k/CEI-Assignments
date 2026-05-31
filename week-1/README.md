# Week 1 Data Engineering Assignment

## Summary

In this assignment, I worked with an e-commerce product dataset using Python and Pandas. The objective was to learn fundamental data engineering tasks such as loading data, exploring dataset structure, handling missing values, filtering records, checking data quality, creating derived features, and exporting cleaned data.

The dataset contains product-related information including product titles, categories, prices, ratings, discounts, seller details, customer reviews, and other product metadata.

---

## Load a CSV Dataset into a Pandas DataFrame

I loaded the dataset into a Pandas DataFrame using the `pd.read_csv()` function.

After loading the data, I verified the import by displaying the dataset and inspecting sample records.

---

## Explore the Dataset

To understand the structure and contents of the dataset, I used several Pandas functions including:

* `head()`
* `tail()`
* `columns`
* `shape`
* `info()`
* `dtypes`

These functions helped me examine:

* Number of rows and columns
* Column names
* Data types
* Missing values
* Overall dataset structure

The dataset contains product information such as:

* Product title
* Category
* Initial price
* Final price
* Discount percentage
* Rating
* Seller details
* Customer reviews
* Product variations and media information

---

## Handle Missing Values

I checked for missing values using:

```python
df.isnull().sum()
```

After identifying columns containing null values, I applied appropriate cleaning techniques based on the type and importance of each column.

### Discount Column

Missing values in the `discount` column were replaced with:

```python
df['discount'] = df['discount'].fillna(0)
```

Since a missing discount can reasonably indicate that no discount is available, replacing null values with 0 helped preserve the records.

### Seller Name Column

Missing seller names were replaced with:

```python
df['seller_name'] = df['seller_name'].fillna("Unknown")
```

### Seller Information Column

Missing seller information was replaced with:

```python
df['seller_information'] = df['seller_information'].fillna("Not Available")
```

### Customer Reviews Column

The `what_customers_said` column contained customer feedback and reviews. Since this information can be valuable for future analysis, I retained the column and replaced missing values with:

```python
df['what_customers_said'] = df['what_customers_said'].fillna("No Review")
```

This allowed me to preserve potentially useful customer review information while eliminating missing values.

### Remove Highly Incomplete Columns

The following columns contained a very high percentage of missing values and were not required for the current analysis:

* `videos`
* `variations`

```python
df = df.drop(columns=['videos','variations'])
```

After these operations, the dataset contained significantly fewer missing values and was ready for further analysis.

---

## Perform Basic Operations

I performed several common data manipulation operations.

### Select Specific Columns

I created a smaller DataFrame containing only:

* Title
* Category
* Final Price
* Rating

```python
prod_info = df[['title','category','final_price','rating']]
```

### Filter Products by Category

I filtered products belonging to the **watches** category:

```python
watches = df[df['category'] == 'watches']
```

### Filter Highly Rated Products

I extracted products with ratings greater than 4:

```python
highly_rated = df[df['rating'] > 4]
```

### Multiple Conditions

I filtered products that belong to the **backpacks** category and have ratings greater than 4:

```python
best_backpacks = df[(df['category']=='backpacks') & (df['rating']>4)]
```

These operations demonstrate how Pandas can be used to analyze and extract meaningful subsets of data.

---

## Remove Duplicates

To ensure data quality, I checked for duplicate records using:

```python
df.duplicated().sum()
```

The result showed that the dataset contained no duplicate rows.

Therefore, no records were removed.

This indicates that the dataset was already clean with respect to duplicate entries.

---

## Create a Derived Column

I created a new derived feature called **discount_amount**.

The discount amount was calculated using:

```python
df['discount_amount'] = df['initial_price'] * (df['discount']/100)
```

This new column represents the monetary value of the discount offered on each product.

I then displayed:

* Product title
* Initial price
* Discount percentage
* Discount amount

to verify the calculation.

---

## Save the Cleaned Dataset

After completing all cleaning and transformation steps, I exported the final dataset using:

```python
df.to_csv("cleaned_dataset.csv", index=False)
```

The saved file contains:

* Cleaned and processed data
* Handled missing values
* Preserved customer review information
* Newly created `discount_amount` column

---

## Conclusion

Through this assignment, I gained hands-on experience with fundamental data engineering and data preprocessing tasks using Pandas. I learned how to load datasets, inspect data structures, handle missing values using different strategies, preserve important business information, perform filtering and selection operations, check for duplicates, create derived features, and export processed datasets for further analysis.
