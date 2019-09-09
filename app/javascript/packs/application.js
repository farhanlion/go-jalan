import 'bootstrap';
import improveDropdown from '../plugins/init_select2';
// import {} from 'jquery-ujs';
import 'mapbox-gl/dist/mapbox-gl.css'
import { initMapbox } from '../plugins/init_mapbox';
import { updateBannerOnScroll } from '../components/banner';

initMapbox();

improveDropdown();

updateBannerOnScroll();


