using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class CreateTournamentForm : Form, IPrizeRequester, ITeamRequester
    {
        private List<TeamModel> availableTeams = GlobalConfig.Connection.GetTeams_All();
        private List<TeamModel> selectedTeams = new List<TeamModel>();
        private List<PrizeModel> selectedPrizes = new List<PrizeModel>();
        private List<PersonModel> teamPlayers = new List<PersonModel>();

        ITournamentRequester callingForm;

        public CreateTournamentForm(ITournamentRequester caller)
        {
            InitializeComponent();
            WireUpLists();

            callingForm = caller;
        }

        private void WireUpLists()
        {
            tournamentPlayersListBox.DataSource = null;
            tournamentPlayersListBox.DataSource = selectedTeams;
            tournamentPlayersListBox.DisplayMember = "TeamName";

            selectTeamDropDown.DataSource = null;
            selectTeamDropDown.DataSource = availableTeams;
            selectTeamDropDown.DisplayMember = "TeamName";

            prizeListBox.DataSource = null;
            prizeListBox.DataSource = selectedPrizes;
            prizeListBox.DisplayMember = "PlaceName";
        }

        private void ShowTeamPlayers_DoubleClick(object sender, EventArgs e)
        {
            string outputMessage = "";
            foreach (TeamModel team in selectedTeams)
            {
                foreach (PersonModel person in team.TeamMembers)
                {
                    teamPlayers.Add(person);

                    outputMessage += (
                        "\n Team Name: " + team.TeamName +
                        "\n Name: " + person.FullName +
                        "\n Email: " + person.EmailAddress +
                        "\n Cellphone number: " + person.CellphoneNumber +
                        "\n"
                    );
                }
            }

            MessageBox.Show(outputMessage);
        }

        private void AddTeamButton_Click(object sender, EventArgs e)
        {
            TeamModel t = (TeamModel)selectTeamDropDown.SelectedItem;

            selectedTeams.Add(t);
            availableTeams.Remove(t);

            WireUpLists();
        }

        private void DeleteSelectedPlayerButton_Click(object sender, EventArgs e)
        {
            TeamModel t = (TeamModel)tournamentPlayersListBox.SelectedItem;

            if (t != null)
            {
                selectedTeams.Remove(t);
                availableTeams.Add(t);
                WireUpLists();
            }
        }

        private void DeleteSelectedPrizeButton_Click(object sender, EventArgs e)
        {
            PrizeModel p = (PrizeModel)prizeListBox.SelectedItem;

            if (p != null)
            {
                selectedPrizes.Remove(p);
                WireUpLists();
            }
        }

        private void CreateTournamentForm_Load(object sender, EventArgs e)
        {

        }

        private void CreatePrizeButton_Click(object sender, EventArgs e)
        {
            CreatePrizeForm createPrizeForm = new CreatePrizeForm(this);
            createPrizeForm.Show();

        }

        public void PrizeComplete(PrizeModel model)
        {
            selectedPrizes.Add(model);
            WireUpLists();
        }

        private void CreateNewTeamLink_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            CreateTeamForm createTeamForm = new CreateTeamForm(this);
            createTeamForm.Show();
        }

        public void TeamComplete(TeamModel model)
        {
            selectedTeams.Add(model);
            WireUpLists();
        }

        private void CreateTournamentButton_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                TournamentModel tournament = new TournamentModel
                {
                    TournamentName = tournamentNameValue.Text,
                    EntryFee = decimal.Parse(entryFeeValue.Text),
                    EnteredTeams = selectedTeams,
                    Prizes = selectedPrizes
                };

                TournamentLogic.CreateRounds(tournament);

                GlobalConfig.Connection.CreateTournament(tournament);

                tournament.AlertUsersToNewRound();

                callingForm.TournamentComplete(tournament);

                MessageBox.Show("Tournament created successfully!");
                this.Close();
            }
            else
            {
                MessageBox.Show("Error while creating tournament, try again.");
            }

            bool ValidateForm()
            {
                var output = true;

                if (tournamentNameValue.Text.Length == 0)
                {
                    output = false;
                }

                if (tournamentPlayersListBox.Items.Count == 0)
                {
                    output = false;
                }

                if (prizeListBox.Items.Count == 0)
                {
                    output = false;
                }

                if (!decimal.TryParse(entryFeeValue.Text, out decimal entryFee))
                {
                    output = false;
                }

                if (entryFee < 0)
                {
                    output = false;
                }

                return output;
            }
        }
    }
}
