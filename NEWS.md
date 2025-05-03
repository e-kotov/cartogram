# cartogram 0.4.0

* The new `n_cpu` option in `cartogram_cont()` and `cartogram_ncont()` enables distortion calculation across multiple CPU cores (thanks to [e-kotov](https://github.com/e-kotov)!)
* The default threshold value in `cartogram_cont()` will now automatically increase if the weighting variable contains a significant number of zeros.
* Additional tests have been implemented.

# cartogram 0.3.0

* Remove `sp`, `rgdal` and `maptools` from examples and suggestions.
* `cartogram_cont()` has a new parameter `verbose = FALSE` to hide print of size error on each iteration.
 
# cartogram 0.2.2

* Fix geometry replacement in `cartogram_ncont`

# cartogram 0.2.0

* Migrated all functions to sf, fixed problems with multipolygons.
* cartogram functions won't accept features with longitude/latitude coordinates anymore.

# cartogram 0.1.1

* Update sf code. Thanks to [@Nowosad](https://github.com/Nowosad) for speeding things up!

# cartogram 0.1.0

* Non-Overlapping Circles Cartogram (Dorling)

# cartogram 0.0.3

* sf support added

# cartogram 0.0.2

* Non-contiguous Area Cartogram
* Prepare data with missing or extreme values before cartogram calculation for faster convergence

# cartogram 0.0.1

* Initial Release
