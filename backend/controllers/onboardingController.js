
const { Onboarding } = require('../models');

exports.saveLanguage = async (req, res) => {
  try {
    const { language } = req.body;

    if (!language) {
      return res.status(400).json({ message: 'Language is required' });
    }

    // Save anonymous onboarding
    const onboarding = await Onboarding.create({
      selectedLanguage: language,
    });

    // Count how many selected this language
    const count = await Onboarding.count({
      where: { selectedLanguage: language },
    });

    res.status(201).json({
      onboardingId: onboarding.id,
      language,
      count,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * STEP 2: Update experience level
 */
exports.saveLevel = async (req, res) => {
  try {
    const { onboardingId, level } = req.body;

    if (!onboardingId || !level) {
      return res.status(400).json({ message: 'Missing data' });
    }

    await Onboarding.update(
      { experienceLevel: level },
      { where: { id: onboardingId } }
    );

    res.json({ message: 'Level saved successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.saveReason = async (req, res) => {
  try {
    const { onboardingId, reason } = req.body;
    await Onboarding.update({ learningReason: reason }, { where: { id: onboardingId } });
    res.json({ message: 'Reason saved successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.savePreparations = async (req, res) => {
  try {
    const { onboardingId, preparations } = req.body;
    await Onboarding.update({ preparations }, { where: { id: onboardingId } });
    res.json({ message: 'Preparations saved successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.saveDailyGoal = async (req, res) => {
  try {
    const { onboardingId, dailyGoal } = req.body;
    await Onboarding.update({ dailyGoal }, { where: { id: onboardingId } });
    res.json({ message: 'Daily goal saved successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
exports.getLanguageCount = async (req, res) => {
  try {
    const { language } = req.params;

    const count = await Onboarding.count({
      where: { selectedLanguage: language },
    });

    res.json({ count });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

