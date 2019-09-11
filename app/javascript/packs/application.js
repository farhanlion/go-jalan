require('jquery');

import 'bootstrap';
import improveDropdown from '../plugins/init_select2';
// import {} from 'jquery-ujs';
import 'mapbox-gl/dist/mapbox-gl.css'
import 'select2/dist/css/select2.css';

import { initMapbox } from '../plugins/init_mapbox';
import { initStarRating } from '../plugins/init_star_rating';
import { triggerForm } from '../components/review-form';
import {seeMore} from '../components/provider_description.js';
import { updateBannerOnScroll } from '../components/banner';
import {goBack} from '../components/back.js'
import {likeHeart} from '../components/hearts.js'
// <<<<<<< HEAD
// import { infiniteScroll } from '../plugins/react_visit.js'
// =======

initStarRating();

initMapbox();

improveDropdown();

// infiniteScroll();

seeMore();

triggerForm();

updateBannerOnScroll();

goBack();


