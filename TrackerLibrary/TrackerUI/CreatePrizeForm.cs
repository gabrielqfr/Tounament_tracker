using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.DataAccess;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class CreatePrizeForm : Form
    {
        public CreatePrizeForm()
        {
            InitializeComponent();
        }

        private void CreatePrizeButton_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                PrizeModel model = new PrizeModel(
                    placeNameValue.Text, 
                    placeNumberValue.Text, 
                    prizeAmountValue.Text, 
                    prizePercentageValue.Text);

                GlobalConfig.Connection.CreatePrize(model);
                
                MessageBox.Show("Prize created successfully!");
                ResetForm();
            }
            else
            {
                MessageBox.Show("This form has invalid or missing information. Please check it and try again.");
            }
        }

        private bool ValidateForm()
        {
            bool output = true;

            if (!int.TryParse(placeNumberValue.Text, out int placeNumber))
            {
                output = false;
            }

            if (placeNumber < 1)
            {
                output = false;
            }

            if (placeNameValue.Text.Length == 0)
            {
                output = false;
            }

            if (!decimal.TryParse(prizeAmountValue.Text, out decimal prizeAmount))
            {
                output = false;
            }

            if (!double.TryParse(prizePercentageValue.Text, out double prizePercentage))
            {
                output = false;
            }

            if (prizeAmount <= 0 && prizePercentage <= 0)
            {
                output = false;
            }

            if (prizePercentage < 0 || prizePercentage > 100)
            {
                output = false;
            }

            return output;
        }

        private void ResetForm()
        {
            placeNameValue.Clear();
            placeNumberValue.Clear();
            prizeAmountValue.Text = "0";
            prizePercentageValue.Text = "0";
        }
    }
}
