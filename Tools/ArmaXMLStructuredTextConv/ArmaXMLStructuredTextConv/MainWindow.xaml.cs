using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ArmaXMLStructuredTextConv
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void buttonFrom_Click(object sender, RoutedEventArgs e)
        {
            text.Text = text.Text.Replace("&lt;", "<").Replace("&gt;", ">");
        }

        private void buttonTo_Click(object sender, RoutedEventArgs e)
        {
            text.Text = text.Text.Replace("<", "&lt;").Replace(">", "&gt;");
        }
    }
}
