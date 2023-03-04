using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ItemTextManager : MonoBehaviour
{
    [SerializeField]
    private List<Transform> textMeshTransforms;

    void Update () 
    {
        foreach (Transform textMeshTransform in textMeshTransforms) {
            textMeshTransform.rotation = Quaternion.LookRotation( textMeshTransform.position - Camera.main.transform.position );
        }
    }
}
