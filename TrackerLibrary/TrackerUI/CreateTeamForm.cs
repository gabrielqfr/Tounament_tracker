using System;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class CreateTeamForm : Form
    {
        public CreateTeamForm()
        {
            InitializeComponent();
        }

        private void CreateMemberButton_Click(object sender, EventArgs e)
        {
            if (ValidateCreateMemberForm())
            {
                PersonModel person = new PersonModel
                {
                    FirstName = firstNameValue.Text,
                    LastName = LastNameValue.Text,
                    EmailAddress = emailValue.Text,
                    CellphoneNumber = cellphoneValue.Text
                };

                GlobalConfig.Connection.CreatePerson(person);

                MessageBox.Show("Member added successfully!");
                ResetCreateMemberForm();
            }
            else
            {
                MessageBox.Show("This form has invalid or missing information. Please check it and try again.");
            }
        }

        private bool ValidateCreateMemberForm()
        {
            bool output = true;

            if (firstNameValue.Text.Length == 0 || LastNameValue.Text.Length == 0)
            {
                output = false;
            }

            if (!emailValue.Text.Contains("@") || !emailValue.Text.Contains(".") || emailValue.Text.Length == 0)
            {
                output = false;
            }

            if (cellphoneValue.Text.Length > 20)
            {
                output = false;
            }

            return output;
        }

        private void ResetCreateMemberForm()
        {
            firstNameValue.Clear();
            LastNameValue.Clear();
            emailValue.Clear();
            cellphoneValue.Clear();
        }
    }
}
