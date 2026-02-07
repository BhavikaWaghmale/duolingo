import { DataTypes } from 'sequelize';

export default (sequelize) => {
  return sequelize.define(
    'Onboarding',
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      language: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      level: {
        type: DataTypes.STRING,
        allowNull: true,
      },
    },
    {
      tableName: 'onboarding',
      freezeTableName: true,
      timestamps: false,
    }
  );
};
