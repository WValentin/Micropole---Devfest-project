using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    [SerializeField]
    private Text collectText;

    [SerializeField]
    private Text tubeText;

    [SerializeField]
    private Text leverText;

    [SerializeField]
    private Text valveText;

    public void CollectTube()
    {
        collectText.text = "Objets collectés  1/3: ";
        tubeText.color = Color.green;
    }

    public void CollectLever()
    {
        collectText.text = "Objets collectés  2/3: ";
        leverText.color = Color.green;
    }

    public void CollectValve()
    {
        collectText.text = "Retournez au sous-marin ";
        tubeText.text = "";
        leverText.text = "";
        valveText.text = "";
    }
}
