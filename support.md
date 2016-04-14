
# KML Support and Compatibility table for GeoAdmin

There is the official kml standard (2 Versions). There are the google extensions
to the standard. There is kml support in OpenLayers 3. There is kml support
in Cesium. And then there's kml support in GeoAdmin.

We need to analyse those sets. 

The goal is to have a clear definition of what flavor of kml we support in
GeoAdmin - effectively creating a KML Application Profile. This will allow us to clearly verify/validate an external KML during import
(kml schema validator + additional checks); change it to fullfil the requirements
for GeoAdmin and eventually allow the user to modify its content.

It should also be noted that currently, our Cesium/3D kml support in GeoAdmin is passing via ol3-cesium. The kml is parsed by openlayers3 and the resulting features are transformed via ol3-cesium to Cesium Features. Therefore, our 3D KML support is limited by ol3. Cesium would offer additional features to the ones supported by ol3 - a native Cesium KML support in map.geo might make sense. In a first step, Cesium KML support is not analysed.

## KML Standards

The followin standards and resources were used in this document.

[OGC KML Standard 2.2 07-147r2](http://portal.opengeospatial.org/files/?artifact_id=27810)

[OGC Abstract Test Suite for 2.2](http://portal.opengeospatial.org/files/?artifact_id=27811&passcode=npks1a6s9ubp6cb3qjuy)

[Google Extensions (based on 2.2](https://developers.google.com/kml/documentation/kmlreference)

[OGC KML Standard 2.3 12-007r2](http://docs.opengeospatial.org/is/12-007r2/12-007r2.html)

[OTC Abstract Test Suite for 2.3](http://docs.opengeospatial.org/ts/14-068r2/14-068r2.html)


## Tables

Necessarily a subset of all existing elements/attributes of the KML standard. If an element or
attributed is not mentioned, we assume that it's not supported.

It should be noted that when a feature/attributed is not parsed during import, it will be lost when written back to the kml.

Element | Standards | Openlayers 3 Support | Google | GeoAdmin
------- | --------- | -------------------- | ------ | --------
Document/Folder | 2.2 | :large_orange_diamond: Parsed as container for other elements. Ol3 does not care about the hierarchy of Documents and Folders. All elements of those containers end up as ol3 features on the same layer | Used for hierarchy in tree | No effect
Schema | 2.2 | :x: not parsed | ? | No effect
SimpleField | 2.2 | :x: not parsed | ? | No effect
Placemark | 2.2 | :white_check_mark: Parsed and transformed to ol.Feature | Full support | Supported. If no style is available, a default style is applied. If no name is available, only the geometry is shown on the map. This is the same behaviour as google.
NetworkLink | 2.2 | :large_orange_diamond: Parsed, downloaded and each linked file parsed and loaded | Full support | All Features of all Networklinks are added to the layer. Cascading Networklink does not fully work. Needs further analysis. Also, local links to filesystem does not work. Furthermore, Networklink specific sub-elements like flyToView, refreshVisibility, etc is not supported at all
Region | 2.2 | :x: not parsed | ? | no effect. Could be interesting feature. Theoretically, it could be used to define KML based vector tiles pyramids and even 3D k-d trees. [See here](https://developers.google.com/kml/documentation/regions)
Feature/name | 2.2 | :white_check_mark: Displayed on map | Earth: displayed on map. Maps: displayed in list only | Displayed on map when it's a point. With other geometries, nothing is displayed. Different placement than Earth
Feature/description | 2.2 | :large_orange_diamond: parsed as ol3 property. | In tooltip. HTML description support not known | shown in tooltip, including html which might contain any html snippet. but specs describe much more functionality that could be of interest, like links to other features inside same kml, link to hoter kmls and their features, flyto, etc.
Feature/styleUrl | 2.2 | :white_check_mark: parsed as ol3 property. Workaround to support non-standard URLS (those missing #). It seems only local URL's supported. | Supported | Supported
Feature/visibility | 2.2 | :x: parsed as ol3 property | Supported in Earth, not supported in Maps | no effect
Feature/open | 2.2 | :x: parsed as ol3 property, no effect | Open/Active in list view | no effect
Feature/author | 2.2 | :x: not parsed | ? | no effect
Feature/link | 2.2 | :x: not parsed | ? | no effect
Feature/address | 2.2 | :x: parsed as ol3 property, no effect | ? | no effect
Feature/phoneNumber | 2.2 | :x: parsed as ol3 property, no effect | ? | no effect
Feature/snippet | 2.2 | :x: not parsed | short description in list view (Earth only) | no effect
Feature/ExtendedData | 2.2 | :x: parsed as ol3 property? | ? | no effect. All Data Elements (Data and SimpleData as well) have sub-elements. These elements allow to define custom key/value pairs for a given Feature.
Feature/altitudeMode | 2.2 | :x: parsed as ol3 property | ? | no effect.
Feature/extrude | 2.2 | :x: parsed as ol3 property | ? | no effect.
Feature/tessellate | 2.2 | :x: not parsed | ? | no effect.
Geometry/MultiGeometry | 2.2 | :large_orange_diamond: parsed in ol3 as either GeometryCollection (if group contains heterogenous geometries) or MultiPoint, MultiLineString, MultiPolygon. **Writing back those types needs analysis.** It's not clear that all information is kept. | ? | Detailed analyses about type of geometries still missing
Geometry/Point | 2.2 | :white_check_mark: parsed in ol3 as Point | ? | Point.
Geometry/LinearRing | 2.2 | :large_orange_diamond: parsed in ol3 as LinearRing | Polyline | Filled Polygon in map.geo, it's closed automatically when 1st point and last point are not the same. This was tested with a simple LinearRing without the Polygon element. A LinearRing inside a Polygon element might be handled differently
Geometry/LineString | 2.2 | :white_check_mark: parsed in ol3 as LineString | Polyline | Polyline/LineString

Continue with Polygon...
