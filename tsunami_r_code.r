import plotly.express as px

PROCESSED_DATA_PATH = "data/processed/tsunami-events.csv"

def preprocess(year_start, year_end):
    df = pd.read_csv(PROCESSED_DATA_PATH)
    df$tsunami_instance <- range(1, len(df) + 1)
    df <- df %>%
                column_to_rownames('tsunami_instance')
    df$combine <- paste(df$country.astype(str), ', ', df$country.astype(str))
    df <- subset(df, (tsunami_intensity > 0))
    df <- subset(df, (year_start <= year & year <= year_end))
    df <- df.sort_values(by=['tsunami_intensity'], ascending = False)
    df <- df[1:11]
    return df

def create_bar_plot(year_start, year_end){
    df <- preprocess(year_start, year_end)
    chart = ggplot(df, aes(x = tsunami_intensity, y = reorder(tsunami_instance, -tsunami_intensity),
                     color = country)) +
            geom_histogram() +
            xlim(0, 12) +
            xlab('Tsunami Intensity') +
            ylab('Country'))
    ggplotly(chart + aes(text = country, location_name, tsunami_intensity,
                                earthquake_magnitude, year, month), 
                        tooltip = ('country', 'location_name', 'tsunami_intensity',
                                'earthquake_magnitude', 'year', 'month'))
    }