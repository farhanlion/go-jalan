import 'bootstrap';
import improveDropdown from '../plugins/init_select2';
// import {} from 'jquery-ujs';
import 'mapbox-gl/dist/mapbox-gl.css'
import { initMapbox } from '../plugins/init_mapbox';
import {seeMore} from '../components/provider_description.js';
import { updateBannerOnScroll } from '../components/banner';
import { infiniteScroll } from '../plugins/react_visit.js'

initMapbox();

improveDropdown();

infiniteScroll();

seeMore();

updateBannerOnScroll();



