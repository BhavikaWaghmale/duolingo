const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  return sequelize.define('Onboarding', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },

    selectedLanguage: {
      type: DataTypes.STRING,
      allowNull: false,
    },

    experienceLevel: {
      type: DataTypes.STRING,
      allowNull: true,
    },

    userId: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
  });
};
