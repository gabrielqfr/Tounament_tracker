using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
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
            TournamentViewerForm tournamentViewerForm = new TournamentViewerForm();
            tournamentViewerForm.Show();
            this.Close();
        }

        public void TournamentComplete(TournamentModel model)
        {
            tournaments.Add(model);
            WireUpTournaments();
        }
    }
}
