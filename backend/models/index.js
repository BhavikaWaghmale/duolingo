const sequelize = require('../config/database');

const User = require('./user')(sequelize);
const Onboarding = require('./onboarding')(sequelize);

// Relations
User.hasOne(Onboarding, { foreignKey: 'userId' });
Onboarding.belongsTo(User, { foreignKey: 'userId' });

module.exports = {
  sequelize,
  User,
  Onboarding,
};
