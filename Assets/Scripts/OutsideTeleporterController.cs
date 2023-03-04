using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OutsideTeleporterController : MonoBehaviour
{
    [SerializeField]
    private CSceneManager sceneManager;

    [SerializeField]
    private AudioManager audioManager;

    [SerializeField]
    private GameObject player;

    [SerializeField]
    private GameObject playerCamera;

    [SerializeField]
    private GameObject teleporterExit;

    [SerializeField]
    private GameObject crabs;

    [SerializeField]
    private GameObject submarineLights;

    public int unlock = 0;

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
            EnterSubmarine();
    }

    public void EnterSubmarine()
    {
        if (unlock == 3) 
        {
            crabs.SetActive(false);
            submarineLights.SetActive(true);
            audioManager.SetSubmarineAmbient();
            player.gameObject.transform.position = teleporterExit.transform.position;
            player.transform.Rotate(0f, 90f, 0f, Space.World);
            playerCamera.transform.position = new Vector3(0f, 0f, 0f);
            sceneManager.ShowRoomObjectsIndicators();
            sceneManager.EnableBeltItemsGrab();
        }
        else
        {
            audioManager.PlayEnterSubmarineDenied();
        }
    }

    public void AddUnlock()
    {
        unlock++;
    }
}
