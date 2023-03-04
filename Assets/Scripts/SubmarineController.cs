using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SubmarineController : MonoBehaviour
{
    [SerializeField]
    private List<GameObject> KeyObjects;

    [SerializeField]
    private List<GameObject> ObjectIndicators;

    // // Start is called before the first frame update
    // void Start()
    // {
        
    // }

    // // Update is called once per frame
    // void Update()
    // {
        
    // }

    public void RemoveObjects()
    {
        foreach (GameObject obj in KeyObjects) {
            obj.SetActive(false);
        }
        foreach (GameObject obj in ObjectIndicators) {
            obj.SetActive(true);
        }
    }
}
