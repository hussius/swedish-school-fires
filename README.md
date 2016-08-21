# School fires in Sweden

*This has been posted as a Kaggle Dataset (https://www.kaggle.com/mikaelhuss/swedish-school-fires).*

## Background

Sweden has a surprisingly large number of school fires for a small country (<10 million inhabitants), and many of these fires are due to arson. According to the [Division of Fire Safety Engineering at Lund University](http://www.brand.lth.se/research/fire-development/arson-fires/), "Almost every day between one and two school fires occur in Sweden. In most cases arson is the cause of the fire." The associated costs can be up to a billion SEK (around 120 million USD) per year.

It is hard to say why these fires are so common in Sweden compared to other countries, and this dataset doesn't address that question - but could it be possible, within a Swedish context, to find out which properties and indicators of Swedish towns (municipalities, to be exact) might be related to a high frequency of school fires?

I have collected data on school fire cases in Sweden between 1998 and 2014 through a web site with official statistics from the [Swedish Civil Contingencies Agency](https://ida.msb.se/ida2#page=a0087). At least at the time when I collected the data, there was no API to allow easy access to schools fire data, so I had to collect them using a quasi-manual process, downloading XLSX report generated from the database year by year, after which I joined these with an R script into a single table of school fire cases where the suspected reason was arson. (see below for full details)

The number of such cases is reported for each municipality (of which there are currently 290) and year (i e each row is a unique municipality/year combination). The population at the time is also reported.

As a complement to these data, I provide a list of municipal KPI:s (key performance indicators) from 2014. There are thousands of these KPI:s, and it would be a futile task for me to try to translate them from Swedish to English. These KPIs were extracted from Kolada (a database of Swedish municipality and county council statistics) by repeatedly querying its [API](https://github.com/Hypergene/kolada).

I'd be very interested to hear if anyone finds some interesting correlations between schools fire cases and municipality indicators! 

## Details

The gory details behind how the data were downloaded are as follows.

- Create an account at the the [Swedish Civil Contingencies Agency's (MSB's) statistics site](https://ida.msb.se/ida2#page=a0046).
- Log into your account. 
- Go to the ["Bränder i byggnader"](http://ida.msb.se/ida2#page=a0109) ("fires in buildings") part of the statistics site.
- Select "Fridyk i databasen" from the left-hand menu.
- Select "Brand i byggnad" ("fire in building").

This opens an interactive interface where you can compose your own queries. In order to get the arson fires in schools per municipality for 2013, for instance, use the following steps:

- Select "Byggnadsgrupp" (type of building) on the right
- Select "Allmän byggnad" (public building) on the left
- Select "Byggnad" (building) on the right
- Select "Skola" (school) on the left
- Select "Brandorsak" (cause of fire) on the right
- Select "Anlagd med uppsåt" (started intentionally) on the left
- Select "År" (year) on the right
- Select 2013 on the left
- Select "Kommun" (municipality) on the right
- Click the XLS button to export.