using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class QuizManager : MonoBehaviour
{
    [SerializeField]
    private GameObject validateButton;
    [SerializeField]
    private GameObject question5ValidateButton;

    [SerializeField]
    private Image awnserAButtonImage;
    [SerializeField]
    private Image awnserBButtonImage;
    [SerializeField]
    private Image awnserCButtonImage;
    [SerializeField]
    private Image awnserDButtonImage;

    [SerializeField]
    private Image question5AwnserAButtonImage;
    [SerializeField]
    private Image question5AwnserBButtonImage;
    [SerializeField]
    private Image question5AwnserCButtonImage;
    [SerializeField]
    private Image question5AwnserDButtonImage;
    [SerializeField]
    private Image question5AwnserEButtonImage;

    [SerializeField]
    private Text questionText;
    [SerializeField]
    private Text awnserAText;
    [SerializeField]
    private Text awnserBText;
    [SerializeField]
    private Text awnserCText;
    [SerializeField]
    private Text awnserDText;

    [SerializeField]
    private GameObject scorePanel;
    [SerializeField]
    private GameObject question5Panel;
    [SerializeField]
    private GameObject mainPanel;

    [SerializeField]
    private Text scoreValue;

    [SerializeField]
    private Text enteredEmail;

    private Color transparent = new Color32(204, 204, 204, 255);
    private Color selected = new Color32(66, 83, 152, 255);
    private List<int> selectedAwnsers = new List<int>();
    private int selectedAwnser = 0;
    private int actualAwnser = 1;
    private int result = 0;

    void Update()
    {
        if (selectedAwnsers.Count == 0 && actualAwnser == 3)
            validateButton.SetActive(false);
    }

    public void ShowValidateButton()
    {
        validateButton.SetActive(true);
    }

    public void SelectResponseA()
    {
        if (actualAwnser == 5)
        {
            question5AwnserAButtonImage.color = selected;
            question5AwnserBButtonImage.color = transparent;
            question5AwnserCButtonImage.color = transparent;
            question5AwnserDButtonImage.color = transparent;
            question5AwnserEButtonImage.color = transparent;
            question5ValidateButton.SetActive(true);
        }
        else if (actualAwnser != 3)
        {
            awnserAButtonImage.color = selected;
            awnserBButtonImage.color = transparent;
            awnserCButtonImage.color = transparent;
            awnserDButtonImage.color = transparent;
            validateButton.SetActive(true);
        }
        else 
        {
            if (selectedAwnsers.Contains(1))
            {
                awnserAButtonImage.color = transparent;
                selectedAwnsers.Remove(1);
            } else
            {
                awnserAButtonImage.color = selected;
                selectedAwnsers.Add(1);
            }
            validateButton.SetActive(true);
        }
        selectedAwnser = 1;
    }

    public void SelectResponseB()
    {
        if (actualAwnser == 5)
        {
            question5AwnserAButtonImage.color = transparent;
            question5AwnserBButtonImage.color = selected;
            question5AwnserCButtonImage.color = transparent;
            question5AwnserDButtonImage.color = transparent;
            question5AwnserEButtonImage.color = transparent;
            question5ValidateButton.SetActive(true);
        }
        else if (actualAwnser != 3)
        {
            awnserAButtonImage.color = transparent;
            awnserBButtonImage.color = selected;
            awnserCButtonImage.color = transparent;
            awnserDButtonImage.color = transparent;
            validateButton.SetActive(true);
        }
        else 
        {
            if (selectedAwnsers.Contains(2))
            {
                awnserBButtonImage.color = transparent;
                selectedAwnsers.Remove(2);
            } else
            {
                awnserBButtonImage.color = selected;
                selectedAwnsers.Add(2);
            }
            validateButton.SetActive(true);
        }
        selectedAwnser = 2;
        validateButton.SetActive(true);
    }

    public void SelectResponseC()
    {
        if (actualAwnser == 5)
        {
            question5AwnserAButtonImage.color = transparent;
            question5AwnserBButtonImage.color = transparent;
            question5AwnserCButtonImage.color = selected;
            question5AwnserDButtonImage.color = transparent;
            question5AwnserEButtonImage.color = transparent;
            question5ValidateButton.SetActive(true);
        }
        else if (actualAwnser != 3)
        {
            awnserAButtonImage.color = transparent;
            awnserBButtonImage.color = transparent;
            awnserCButtonImage.color = selected;
            awnserDButtonImage.color = transparent;
            validateButton.SetActive(true);
        }
        else 
        {
            if (selectedAwnsers.Contains(3))
            {
                awnserCButtonImage.color = transparent;
                selectedAwnsers.Remove(3);
            } else
            {
                awnserCButtonImage.color = selected;
                selectedAwnsers.Add(3);
            }
            validateButton.SetActive(true);
        }
        selectedAwnser = 3;
        validateButton.SetActive(true);
    }

    public void SelectResponseD()
    {
        if (actualAwnser == 5)
        {
            question5AwnserAButtonImage.color = transparent;
            question5AwnserBButtonImage.color = transparent;
            question5AwnserCButtonImage.color = transparent;
            question5AwnserDButtonImage.color = selected;
            question5AwnserEButtonImage.color = transparent;
            question5ValidateButton.SetActive(true);
        }  
        else if (actualAwnser != 3)
        {
            awnserAButtonImage.color = transparent;
            awnserBButtonImage.color = transparent;
            awnserCButtonImage.color = transparent;
            awnserDButtonImage.color = selected;
            validateButton.SetActive(true);
        }
        else 
        {
            if (selectedAwnsers.Contains(4))
            {
                awnserDButtonImage.color = transparent;
                selectedAwnsers.Remove(4);
            } else
            {
                awnserDButtonImage.color = selected;
                selectedAwnsers.Add(4);
            }
            validateButton.SetActive(true);
        }
        selectedAwnser = 4;
        validateButton.SetActive(true);
    }

    public void SelectResponseE()
    {
        question5AwnserAButtonImage.color = transparent;
        question5AwnserBButtonImage.color = transparent;
        question5AwnserCButtonImage.color = transparent;
        question5AwnserDButtonImage.color = transparent;
        question5AwnserEButtonImage.color = selected;
        selectedAwnser = 5;
        question5ValidateButton.SetActive(true);
    }

    public void ValidateQuestion()
    {
        awnserAButtonImage.color = transparent;
        awnserBButtonImage.color = transparent;
        awnserCButtonImage.color = transparent;
        awnserDButtonImage.color = transparent;
        validateButton.SetActive(false);

        switch (actualAwnser)
        {
            case 1: ValidateQuestion1(); break;
            case 2: ValidateQuestion2(); break;
            case 3: ValidateQuestion3(); break;
            case 4: ValidateQuestion4(); break;
            case 5: ValidateQuestion5(); break;
        }

        actualAwnser++;
    }

    private void ValidateQuestion1()
    {
        questionText.text = "Quel âge a Micropole ?";
        awnserAText.text = " A -          + de 50 ans";
        awnserBText.text = " B -          Entre 30 et 50 ans";
        awnserCText.text = " C -          Entre 20 et 30 ans";
        awnserDText.text = " D -          La réponse D";
        if (selectedAwnser == 1)
            result++;
    }

    private void ValidateQuestion2()
    {
        questionText.text = "Quelle technologie que nous utilisons fréquemment avait imaginé Jules Verne ? (choix multiple)";
        awnserAText.text = " A -          La vidéoconférence";
        awnserBText.text = " B -          Internet Explorer";
        awnserCText.text = " C -          La radio";
        awnserDText.text = " D -          La voiture\n                 électrique";
        if (selectedAwnser == 2)
            result++;
    }

    private void ValidateQuestion3()
    {
        questionText.text = "Quel langage de programmation est utilisé pour du développement de projets Metavers ?";
        awnserAText.text = " A -          Cobol";
        awnserBText.text = " B -          Python";
        awnserCText.text = " C -          PHP";
        awnserDText.text = " D -          Aucun des languages\n                 ci-dessus";
        if (selectedAwnsers.Count == 1 && selectedAwnsers[0] == 1)
            result++;
    }

    private void ValidateQuestion4()
    {
        mainPanel.SetActive(false);
        question5Panel.SetActive(true);
        
        if (selectedAwnser == 4)
            result++;
    }

    private void ValidateQuestion5()
    {
        if (selectedAwnser == 2)
            result++;
        
        question5Panel.SetActive(false);
        scorePanel.SetActive(true);
        scoreValue.text = result + " / 5";
    }

    public void ValidateEmail()
    {
        if (enteredEmail.text != "")
            SaveEmail();
    }

    private void SaveEmail()
    {
        string path = Application.persistentDataPath + "/emails.txt";

        System.IO.File.WriteAllText(path, enteredEmail.text + ":        " + result + " / 5" + "\n");
    }
}
