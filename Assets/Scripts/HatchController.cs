using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.Interaction.Toolkit;

public class HatchController : MonoBehaviour
{
    [SerializeField]
    private HingeJoint hinge;

    [SerializeField]
    private GameObject player;

    [SerializeField]
    private GameObject playerCamera;

    [SerializeField]
    private GameObject teleporterExit;

    [SerializeField]
    private List<GameObject> keyItemTubes;

    [SerializeField]
    private List<GameObject> keyItemLevers;

    [SerializeField]
    private GameObject crabs;

    [SerializeField]
    private CSceneManager sceneManager;

    [SerializeField]
    private AudioManager audioManager;

    [SerializeField]
    private GameObject submarineLights;

    void Update()
    {
        // if (hinge.angle >= 175) {
        //     Debug.Log(hinge.angle);
        //     this.enabled = false;
        //     GetComponent<XRGrabInteractable>().enabled = false;
        //     GetComponent<AudioSource>().Play(0);
        //     StartCoroutine(teleportPlayer());
        // }
    }

    public void ExitSubmarine()
    {
        this.enabled = false;
        GetComponent<XRGrabInteractable>().enabled = false;
        GetComponent<AudioSource>().Play(0);
        StartCoroutine(teleportPlayer());
    }

    private IEnumerator teleportPlayer()
    {
        keyItemTubes[(int)Random.Range(0.0f, keyItemTubes.Count)].SetActive(true);
        keyItemLevers[(int)Random.Range(0.0f, keyItemLevers.Count)].SetActive(true);
        yield return new WaitForSeconds(1);
        audioManager.SetOutsideAmbient();
        crabs.SetActive(true);
        submarineLights.SetActive(false);
        player.transform.position = teleporterExit.transform.position;
        player.transform.Rotate(0f, 180f, 0f, Space.World);
        playerCamera.transform.position = new Vector3(0f, 0f, 0f);
        sceneManager.HIdeRoomObjectsIndicators();
        transform.rotation = Quaternion.Euler(new Vector3(transform.rotation.x, 0, transform.rotation.z));
    }
}
