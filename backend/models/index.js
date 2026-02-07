import sequelize from '../config/database.js';
import OnboardingModel from './onboarding.js';

const Onboarding = OnboardingModel(sequelize);

const db = {
  sequelize,
  Onboarding,
};

export default db;
