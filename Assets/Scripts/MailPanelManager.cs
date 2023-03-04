using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MailPanelManager : MonoBehaviour
{
    [SerializeField]
    private Text inputMailText;

    [SerializeField]
    private GameObject mailButtonPanel;
    [SerializeField]
    private GameObject mailButtonPanel2;
    [SerializeField]
    private GameObject mailButtonPanel3;
    [SerializeField]
    private GameObject mailButtonPanel4;

    [SerializeField]
    private Text cycleButtonText;

    [SerializeField]
    private Text buttonTypeText;

    private string inputMail = "";

    // void Start()
    // {
        
    // }

    void Update()
    {
        inputMailText.text = inputMail;
    }

    public void CharacterInput(string str)
    {
        inputMail += str;
    }

    public void DeleteInput()
    {
        if (inputMail != "")
            inputMail = inputMail.Substring(0, inputMail.Length - 1);
    }

    public void SpaceInput()
    {
        if (inputMail != "")
            inputMail += " ";
    }

    public void TypeChange()
    {
        if (buttonTypeText.text == "!#1")
        {
            mailButtonPanel.SetActive(false);
            mailButtonPanel2.SetActive(false);
            mailButtonPanel3.SetActive(true);
            buttonTypeText.text = "ABC";
            cycleButtonText.text = "1/2";
        }
        else
        {
            mailButtonPanel.SetActive(true);
            mailButtonPanel3.SetActive(false);
            mailButtonPanel4.SetActive(false);
            buttonTypeText.text = "!#1";
            cycleButtonText.text = "MAJ";
        }
    }

    public void CycleInputButtons()
    {
        if (buttonTypeText.text == "!#1")
        {
            if (cycleButtonText.text == "MAJ")
            {
                mailButtonPanel.SetActive(false);
                mailButtonPanel2.SetActive(true);
                cycleButtonText.text = "maj";
            }
            else
            {
                mailButtonPanel.SetActive(true);
                mailButtonPanel2.SetActive(false);
                cycleButtonText.text = "MAJ";
            }
        }
        else
        {
            if (cycleButtonText.text == "1/2")
            {
                mailButtonPanel3.SetActive(false);
                mailButtonPanel4.SetActive(true);
                cycleButtonText.text = "2/2";
            }
            else
            {
                mailButtonPanel3.SetActive(true);
                mailButtonPanel4.SetActive(false);
                cycleButtonText.text = "1/2";
            }
        }
    }
}
