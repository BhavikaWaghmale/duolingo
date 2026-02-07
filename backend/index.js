const express = require('express');
const { Sequelize } = require('sequelize');
const onboardingRoutes = require('./routes/onboardingRoutes');
require('dotenv').config();

const app = express();
app.use(express.json());


// Allow CORS for development (adjust in production)
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET,POST,PUT,PATCH,DELETE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  if (req.method === 'OPTIONS') return res.sendStatus(200);
  next();
});

// First, create database if it doesn't exist
const adminSequelize = new Sequelize(
  'postgres',
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: 'postgres',
    logging: false,
  }
);

// Create database and then import models
adminSequelize
  .authenticate()
  .then(() => {
    console.log('Connected to PostgreSQL server');
    return adminSequelize.query(
      `CREATE DATABASE "${process.env.DB_NAME}";`
    );
  })
  .then(() => {
    console.log(`Database "${process.env.DB_NAME}" created successfully`);
    adminSequelize.close();
    startServer();
  })
  .catch((err) => {
    if (err.message.includes('already exists')) {
      console.log(`Database "${process.env.DB_NAME}" already exists`);
      adminSequelize.close();
      startServer();
    } else {
      console.log('Error:', err.message);
      adminSequelize.close();
      startServer();
    }
  });

function startServer() {
  const { sequelize } = require('./models');
  const port = process.env.PORT || 5000;

  app.get('/api/test', (req, res) => {
    res.json({ message: 'Backend is working!', timestamp: new Date() });
  });

  app.use('/api', onboardingRoutes);

  app.listen(port, () => {
    console.log(`Server running on ${port}`);
  });

  sequelize.sync()
    .then(() => console.log('DB connected and synced'))
    .catch(err => console.error('DB error:', err));
}

