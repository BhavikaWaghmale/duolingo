import express from 'express';
import cors from 'cors';

const app = express();

app.use(cors({ origin: '*' }));
app.use(express.json());

// STEP 1: Save language
app.post('/api/onboarding/language', (req, res) => {
  const { language } = req.body;

  if (!language) {
    return res.status(400).json({ error: 'Language required' });
  }

  // 201 because Flutter expects 201
  res.status(201).json({
    onboardingId: 1,
    count: 12000,
    language,
  });
});

// STEP 2: Save experience level
app.post('/api/onboarding/level', (req, res) => {
  const { onboardingId, level } = req.body;

  if (!onboardingId || !level) {
    return res.status(400).json({ error: 'Missing data' });
  }

  res.status(200).json({
    success: true,
    onboardingId,
    level,
  });
});

// OPTIONAL count endpoint (Flutter expects it)
app.get('/api/onboarding/count/:language', (req, res) => {
  res.status(200).json({ count: 12000 });
});

app.listen(5000, () => {
  console.log('Server running on port 5000');
});
