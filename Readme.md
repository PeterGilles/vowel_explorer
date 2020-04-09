###Vowel explorer

By [Peter Gilles](https://twitter.com/PeterGilles)

This app demonstrates the possibility to play audio files directly from `ggplot2` plots in shiny.

The plot shows F1/F2 measurements for 2250 vowel allophones of Luxembourgish /e/ in four different conditions. The basic idea is to give the user the least intrusive possibility to play a sound file from the plot by simply clicking on it without opening a page or a player.

The key aspect is using the `ggiraph` package which allows to include onclick events. The specific onclick event, here play audio from a public URL, is stored as an additional column `onclick` in the main data frame (coming from an `emuR` workflow in my case). `geom_text_interactive` then takes this value for the `onclick` function, similar to the `hover` function.

Below the plot a data table is displayed and it's content is updated according to the selection in the plot.

`Shiny` itself also offers a possibilty to include audio files using `tags$audio`, but I was not able to develop a working solution. Hints can be found [here](https://stackoverflow.com/questions/36205419/r-shiny-audio-playback/36207511#36207511).

The audio data comes from the [Luxembourgish Online Dictionary](https://github.com/spellchecker-lu/lod-audio-mirror) (CC0) and has been automatically segmented using the [MAUS tools](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface).