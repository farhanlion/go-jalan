import mapboxgl from 'mapbox-gl';

const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  });
  window.map = map
  return map
};

const addMarkersToMap = (map, markers) => {
  if (markers.length > 1) {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
  }
  else  {
    const popup = new mapboxgl.Popup().setHTML(markers.infoWindow);
    new mapboxgl.Marker()
        .setLngLat([ markers.lng, markers.lat ])
        .setPopup(popup)
        .addTo(map);
  }
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  if (markers.length > 1) {
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  }
  else {
    bounds.extend([ markers.lng, markers.lat ]);
  }
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const getLocate = (map) => {
  map.addControl(new mapboxgl.GeolocateControl({
    positionOptions: {
      enableHighAccuracy: true
    },
    trackUserLocation: true
    }));
};

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    getLocate(map);
  }
};


export { initMapbox };
