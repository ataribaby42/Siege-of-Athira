using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            soldiers();
            vehicles();
        }  

        private void soldiers()
        {
            int kills = 150;

            Image source = Image.FromFile("c:\\blackboard_L.png");
            Image mark1 = Image.FromFile("c:\\killmark1.png");
            Image mark2 = Image.FromFile("c:\\killmark2.png");
            Image mark3 = Image.FromFile("c:\\killmark3.png");
            Image mark4 = Image.FromFile("c:\\killmark4.png");
            Image mark5 = Image.FromFile("c:\\killmark5.png");

            for (int j = 0; j <= kills; j++)
            {
                Int32 kvalita = 80;
                int killcount = j;
                Bitmap Target = new Bitmap(source.Width, source.Height);
                Graphics Gr = Graphics.FromImage(Target);
                Gr.InterpolationMode = InterpolationMode.Bilinear;
                Gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                Gr.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;

                Gr.DrawImage(source, 0, 0);

                if (j > 0)
                {
                    int x = 60;
                    int y = 155;
                    double scale = 1;
                    int count = 0;
                    int fives = killcount / 5;
                    int reminder = killcount % 5;

                    for (int i = 0; i < fives; i++)
                    {
                        Gr.DrawImage(mark5, x, y, (int)(59 * scale), (int)(65 * scale));
                        x += (int)(62 * scale);
                        count++;
                        if (count > 5)
                        {
                            count = 0;
                            x = 60;
                            y += (int)(62 * scale);
                        }
                    }

                    switch (reminder)
                    {
                        case 1:
                            Gr.DrawImage(mark1, x, y, (int)(59 * scale), (int)(65 * scale));
                            break;
                        case 2:
                            Gr.DrawImage(mark2, x, y, (int)(59 * scale), (int)(65 * scale));
                            break;
                        case 3:
                            Gr.DrawImage(mark3, x, y, (int)(59 * scale), (int)(65 * scale));
                            break;
                        case 4:
                            Gr.DrawImage(mark4, x, y, (int)(59 * scale), (int)(65 * scale));
                            break;
                        default:
                            break;
                    }
                }

                EncoderParameters myEncoderParameters = new EncoderParameters(1);
                EncoderParameter myEncoderParameter = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, kvalita);
                myEncoderParameters.Param[0] = myEncoderParameter;
                Target.Save("c:\\generated\\blackboard_L_" + j + ".jpg", GetEncoderInfo("image/jpeg"), myEncoderParameters);

                Target.Dispose();
                Gr.Dispose();
            }
        }

        private void vehicles()
        {
            int kills = 150;

            Image source = Image.FromFile("c:\\blackboard_R.png");
            Image mark1 = Image.FromFile("c:\\killmark1.png");
            Image mark2 = Image.FromFile("c:\\killmark2.png");
            Image mark3 = Image.FromFile("c:\\killmark3.png");
            Image mark4 = Image.FromFile("c:\\killmark4.png");
            Image mark5 = Image.FromFile("c:\\killmark5.png");

            for (int j = 0; j <= kills; j++)
            {
                Int32 kvalita = 80;
                int killcount = j;
                Bitmap Target = new Bitmap(source.Width, source.Height);
                Graphics Gr = Graphics.FromImage(Target);
                Gr.InterpolationMode = InterpolationMode.Bilinear;
                Gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                Gr.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;

                Gr.DrawImage(source, 0, 0);

                if (j > 0)
                {
                    int x = 60;
                    int y = 155;
                    double scale = 1;
                    int count = 0;
                    int fives = killcount / 5;
                    int reminder = killcount % 5;

                    for (int i = 0; i < fives; i++)
                    {
                        Gr.DrawImage(mark5, x, y, (int)(59 * scale), (int)(65 * scale));
                        x += (int)(62 * scale);
                        count++;
                        if (count > 5)
                        {
                            count = 0;
                            x = 60;
                            y += (int)(62 * scale);
                        }
                    }

                    switch (reminder)
                    {
                        case 1:
                            Gr.DrawImage(mark1, x, y, (int)(59 * scale), (int)(65 * scale));
                            break;
                        case 2:
                            Gr.DrawImage(mark2, x, y, (int)(59 * scale), (int)(65 * scale));
                            break;
                        case 3:
                            Gr.DrawImage(mark3, x, y, (int)(59 * scale), (int)(65 * scale));
                            break;
                        case 4:
                            Gr.DrawImage(mark4, x, y, (int)(59 * scale), (int)(65 * scale));
                            break;
                        default:
                            break;
                    }
                }

                EncoderParameters myEncoderParameters = new EncoderParameters(1);
                EncoderParameter myEncoderParameter = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, kvalita);
                myEncoderParameters.Param[0] = myEncoderParameter;
                Target.Save("c:\\generated\\blackboard_R_" + j + ".jpg", GetEncoderInfo("image/jpeg"), myEncoderParameters);

                Target.Dispose();
                Gr.Dispose();
            }
        }

        private static ImageCodecInfo GetEncoderInfo(String mimeType)
        {
            int j;
            ImageCodecInfo[] encoders;
            encoders = ImageCodecInfo.GetImageEncoders();
            for (j = 0; j < encoders.Length; ++j)
            {
                if (encoders[j].MimeType == mimeType)
                    return encoders[j];
            } return null;
        }
    }
}
