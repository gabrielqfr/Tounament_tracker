using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class TournamentViewerForm : Form
    {
        private TournamentModel tournament;
        BindingList<int> rounds = new BindingList<int>();
        BindingList<MatchupModel> selectedMatchups = new BindingList<MatchupModel>();

        public TournamentViewerForm(TournamentModel tournamentModel)
        {
            InitializeComponent();

            tournament = tournamentModel;

            WireUpLists();
            LoadFormData();
            LoadRounds();
        }

        private void LoadFormData()
        {
            tournamentName.Text = tournament.TournamentName;
        }

        private void WireUpLists()
        {
            roundDropdown.DataSource = rounds;
            matchupListBox.DataSource = selectedMatchups;
            matchupListBox.DisplayMember = "DisplayName";
        }

        private void LoadRounds()
        {
            rounds.Clear();
            rounds.Add(1);
            int currRound = 1;

            foreach (List<MatchupModel> matchups in tournament.Rounds)
            {
                if (matchups.First().MatchupRound > currRound)
                {
                    currRound = matchups.First().MatchupRound;
                    rounds.Add(currRound);
                }
            }

            LoadMatchups(1);
        }

        private void RoundDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadMatchups((int)roundDropdown.SelectedItem);
        }

        private void LoadMatchups(int round)
        {
            foreach (List<MatchupModel> matchups in tournament.Rounds)
            {
                if (matchups.First().MatchupRound == round)
                {
                    selectedMatchups.Clear();
                    foreach (MatchupModel m in matchups)
                    {
                        if (m.Winner == null || !unplayedOnlyCheckbox.Checked)
                        {
                            selectedMatchups.Add(m);
                        }
                    }
                }
            }

            if (selectedMatchups.Count > 0)
            {
                LoadMatchup(selectedMatchups.First());
            }

            DisplayMatchupInfo();
        }

        private void DisplayMatchupInfo()
        {
            bool isVisible = (selectedMatchups.Count > 0);

            teamOneName.Visible = isVisible;
            teamOneScoreLabel.Visible = isVisible;
            teamOneScoreValue.Visible = isVisible;

            teamTwoName.Visible = isVisible;
            teamTwoScoreLabel.Visible = isVisible;
            teamTwoScoreValue.Visible = isVisible;

            versusLabel.Visible = isVisible;
            scoreButton.Visible = isVisible;
        }

        private void MatchupListBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if ((MatchupModel)matchupListBox.SelectedItem != null)
            {
                LoadMatchup((MatchupModel)matchupListBox.SelectedItem);
            }
        }

        private void LoadMatchup(MatchupModel matchup)
        {
            for (int i = 0; i < matchup.Entries.Count; i++)
            {
                if (i == 0)
                {
                    if (matchup.Entries[0].TeamCompeting != null)
                    {
                        teamOneName.Text = matchup.Entries[0].TeamCompeting.TeamName;
                        teamOneScoreValue.Text = matchup.Entries[0].Score.ToString();

                        teamTwoName.Text = "<bye>";
                        teamTwoScoreValue.Text = "0";
                    }
                    else
                    {
                        teamOneName.Text = "Not yet set";
                        teamOneScoreValue.Text = "";
                    }
                }

                if (i == 1)
                {
                    if (matchup.Entries[1].TeamCompeting != null)
                    {
                        teamTwoName.Text = matchup.Entries[1].TeamCompeting.TeamName;
                        teamTwoScoreValue.Text = matchup.Entries[1].Score.ToString();
                    }
                    else
                    {
                        teamTwoName.Text = "Not yet set";
                        teamTwoScoreValue.Text = "";
                    }
                }
            }
        }

        private void ScoreButton_Click(object sender, EventArgs e)
        {
            string errorMessage = ValidateData();
            if (errorMessage.Length > 0)
            {
                MessageBox.Show($"Input error: { errorMessage }");
                return;
            }

            MatchupModel matchup = (MatchupModel)matchupListBox.SelectedItem;
            double teamOneScore = 0, teamTwoScore = 0;

            for (int i = 0; i < matchup.Entries.Count; i++)
            {
                if (i == 0)
                {
                    if (matchup.Entries[0].TeamCompeting != null)
                    {
                        bool scoreValid = double.TryParse(teamOneScoreValue.Text, out teamOneScore);
                        if (scoreValid)
                        {
                            matchup.Entries[0].Score = teamOneScore;
                        }
                        else
                        {
                            MessageBox.Show("Enter a valid score for team one");
                            return;
                        }
                    }
                }

                if (i == 1)
                {
                    if (matchup.Entries[1].TeamCompeting != null)
                    {
                        bool scoreValid = double.TryParse(teamTwoScoreValue.Text, out teamTwoScore);
                        if (scoreValid)
                        {
                            matchup.Entries[1].Score = teamTwoScore;
                        }
                        else
                        {
                            MessageBox.Show("Enter a valid score for team two");
                            return;
                        }
                    }
                }
            }

            try
            {
                TournamentLogic.UpdateTournamentResults(tournament);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"The application had the following error: { ex.Message }");
                return;
            }

            LoadMatchups((int)roundDropdown.SelectedItem);

        }

        private string ValidateData()
        {
            string output = "";

            bool scoreOneValid = double.TryParse(teamOneScoreValue.Text, out double teamOneScore);
            bool scoreTwoValid = double.TryParse(teamTwoScoreValue.Text, out double teamTwoScore);

            if (!scoreOneValid)
            {
                output = "The Score One value is not a valid number";
            }
            else if (!scoreTwoValid)
            {
                output = "The Score Two value is not a valid number";
            }
            else if (teamOneScore == 0 && teamTwoScore == 0)
            {
                output = "You need to enter a score for at least one team";            }
            else if (teamOneScore == teamTwoScore)
            {
                output = "We do not allow ties in this application";
            }

            return output;
        }

        private void UnplayedOnlyCheckbox_CheckedChanged(object sender, EventArgs e)
        {
            LoadMatchups((int)roundDropdown.SelectedItem);
        }
    }
}
