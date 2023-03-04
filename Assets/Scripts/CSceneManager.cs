using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CSceneManager : MonoBehaviour
{
    [SerializeField]
    private GameObject keyObjectsHighlights;

    [SerializeField]
    private List<Collider> beltItemsCollider;

    [SerializeField]
    private List<GameObject> objectsToChange;

    [SerializeField]
    private List<GameObject> bulkLights;

    [SerializeField]
    private List<GameObject> alertBulkLights;

    [SerializeField]
    private Material closedMaterial;

    [SerializeField]
    private Material openedMaterial;

    public int goal = 0;

    public void HIdeRoomObjectsIndicators()
    {
        keyObjectsHighlights.SetActive(false);
    }

    public void ShowRoomObjectsIndicators()
    {
        keyObjectsHighlights.SetActive(true);
    }

    public void EnableBeltItemsGrab()
    {
        foreach (Collider col in beltItemsCollider)
            col.enabled = true;
    }

    public void reachGoal()
    {
        if (goal != 3)
            goal++;

        if (goal == 3)
            StartCoroutine(ReactivateSubmarine());
    }

    private IEnumerator ReactivateSubmarine()
    {
        yield return new WaitForSeconds(3);
        Debug.Log("Reactivating Submarine !");
        foreach (GameObject obj in objectsToChange)
            obj.SetActive(!obj.activeInHierarchy);
        foreach (GameObject obj in alertBulkLights)
            obj.GetComponent<MeshRenderer>().material = closedMaterial;
        foreach (GameObject obj in bulkLights)
            obj.GetComponent<MeshRenderer>().material = openedMaterial;
    }
}
