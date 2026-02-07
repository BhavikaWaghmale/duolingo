console.log('🔥 index.js started');

import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

import db from './models/index.js';

dotenv.config();

const app = express();

app.use(cors({ origin: '*' }));
app.use(express.json());

/* 🔗 CONNECT TO POSTGRES */
await db.sequelize.authenticate();
console.log('✅ PostgreSQL connected');

/* 🔨 SYNC TABLE */
await db.sequelize.sync();

/* =========================
   SAVE LANGUAGE
   ========================= */
app.post('/api/onboarding/language', async (req, res) => {
  console.log('🔥 LANGUAGE ROUTE HIT:', req.body);

  try {
    const { language } = req.body;

    const onboarding = await db.Onboarding.create({
      language,
    });

    console.log('✅ ROW INSERTED:', onboarding.toJSON());

    res.status(201).json({
      onboardingId: onboarding.id,
      count: 12000,
    });
  } catch (err) {
    console.error('❌ INSERT FAILED:', err);
    res.status(500).json({ error: 'Database error' });
  }
});

/* =========================
   SAVE LEVEL
   ========================= */
app.post('/api/onboarding/level', async (req, res) => {
  console.log('🔥 LEVEL ROUTE HIT:', req.body);

  try {
    const { onboardingId, level } = req.body;

    await db.Onboarding.update(
      { level },
      { where: { id: onboardingId } }
    );

    res.json({ success: true });
  } catch (err) {
    console.error('❌ UPDATE FAILED:', err);
    res.status(500).json({ error: 'Database error' });
  }
});

/* 🚀 START SERVER */
console.log('🔥 about to start server');

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
