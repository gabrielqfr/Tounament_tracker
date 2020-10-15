﻿using System;
using System.Collections.Generic;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class CreateTeamForm : Form
    {
        private List<PersonModel> availableTeamMembers = GlobalConfig.Connection.GetPerson_All();
        private List<PersonModel> selectedTeamMembers = new List<PersonModel>();
        public CreateTeamForm()
        {
            InitializeComponent();
            //CreateSampleData();
            WireUpLists();
        }

        private void CreateSampleData()
        {
            selectedTeamMembers.Add(new PersonModel { FirstName = "Gabriel", LastName = "Quirino" });
            selectedTeamMembers.Add(new PersonModel { FirstName = "Gabriel", LastName = "Quirinasdasdasdo" });
            selectedTeamMembers.Add(new PersonModel { FirstName = "Gabriel", LastName = "Quirinoasdasd" });
        }

        private void WireUpLists()
        {
            selectTeamMemberComboBox.DataSource = null;
            selectTeamMemberComboBox.DataSource = availableTeamMembers;
            selectTeamMemberComboBox.DisplayMember = "FullName";

            teamMembersListBox.DataSource = null;
            teamMembersListBox.DataSource = selectedTeamMembers;
            teamMembersListBox.DisplayMember = "FullName";
        }

        private void CreateMemberButton_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
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
                ResetForm();
            }
            else
            {
                MessageBox.Show("This form has invalid or missing information. Please check it and try again.");
            }

            bool ValidateForm()
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

            void ResetForm()
            {
                firstNameValue.Clear();
                LastNameValue.Clear();
                emailValue.Clear();
                cellphoneValue.Clear();
            }
        }

        private void AddMemberButton_Click(object sender, EventArgs e)
        {
            PersonModel p = (PersonModel)selectTeamMemberComboBox.SelectedItem;

            availableTeamMembers.Remove(p);
            selectedTeamMembers.Add(p);

            WireUpLists();
        }

        private void DeleteSelectedMemberButton_Click(object sender, EventArgs e)
        {
            PersonModel p = (PersonModel)teamMembersListBox.SelectedItem;

            selectedTeamMembers.Remove(p);
            availableTeamMembers.Add(p);

            WireUpLists();
        }

        private void CreateTeamButton_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                TeamModel team = new TeamModel
                {
                    TeamName = teamNameValue.Text,
                    TeamMembers = selectedTeamMembers
                };

                GlobalConfig.Connection.CreateTeam(team);
                MessageBox.Show("Team created successfully!");
                ResetForm();
            }
            else
            {
                MessageBox.Show("Error while creating team, try again.");
            }

            bool ValidateForm()
            {
                bool output = true;

                if (teamNameValue.Text.Length == 0)
                {
                    output = false;
                }

                if (teamMembersListBox.Items.Count == 0)
                {
                    output = false;
                }

                return output;
            }

            void ResetForm()
            {
                availableTeamMembers = GlobalConfig.Connection.GetPerson_All();
                selectedTeamMembers = new List<PersonModel>();
                teamNameValue.Clear();
                selectTeamMemberComboBox.Refresh();
                WireUpLists();
            }
        }
    }
}
