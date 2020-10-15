using System;
using System.Collections.Generic;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class TournamentDashboardForm : Form, ITournamentRequester
    {
        List<TournamentModel> tournaments = GlobalConfig.Connection.GetTournaments_All();
        public TournamentDashboardForm()
        {
            InitializeComponent();
            WireUpTournaments();
        }

        private void WireUpTournaments()
        {
            loadExistingTournamentDropdown.DataSource = null;
            loadExistingTournamentDropdown.DataSource = tournaments;
            loadExistingTournamentDropdown.DisplayMember = "TournamentName";
        }

        private void CreateTournamentButton_Click(object sender, EventArgs e)
        {
            CreateTournamentForm createTournamentForm = new CreateTournamentForm(this);
            createTournamentForm.Show();
        }

        private void LoadTournamentButton_Click(object sender, EventArgs e)
        {
            TournamentModel selectedTournament = (TournamentModel)loadExistingTournamentDropdown.SelectedItem;
            TournamentViewerForm tournamentViewerForm = new TournamentViewerForm(selectedTournament);
            tournamentViewerForm.Show();
        }

        public void TournamentComplete(TournamentModel model)
        {
            tournaments.Add(model);
            WireUpTournaments();
        }
    }
}
