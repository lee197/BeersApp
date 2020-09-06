# BeersApp
An app to display a list of beers and it's processing steps.

## Branches:

* master - stable app releases

## Dependencies:

The project is not using any third party cocoapods for managing external libraries

## Project structure:

<p align="center">
  <img src="MVVM.png" />
</p>

* ViewModel: viewmodel objects with all business logic
* Model: data model objects
* Support: resuseable classes
* Domain: Logics for extra calculation out of ViewModel
* Networking Service: Generic Networking Layer
* Uint test: test the all functions in viewmodel with mocked networking service

## Next step:

*  Add unit test on DetailViewModel
*  Add data repository layer to be more scalable if we need database layer
*  Improve the swift coding style: naming, format etc.
*  Make the networking layer more generic

## Author:

*  Qi Li

## Contact:

* https://www.linkedin.com/in/lee-qi/
* www.leeqii.com
