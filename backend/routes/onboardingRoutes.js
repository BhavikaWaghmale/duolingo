// const express = require('express');
// const router = express.Router();
// const controller = require('../controllers/onboardingController');

// router.post('/onboarding', controller.saveOnboarding);

// module.exports = router;
const express = require('express');
const router = express.Router();
const controller = require('../controllers/onboardingController');

// Step 1: language selection
router.post('/onboarding/language', controller.saveLanguage);

// Step 2: experience level
router.post('/onboarding/level', controller.saveLevel);

router.get('/onboarding/count/:language', controller.getLanguageCount);

module.exports = router;
